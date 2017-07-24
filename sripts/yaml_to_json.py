#!/usr/bin/env python3
# Simple script that converts yaml files into json files while
# also preserving the order of any dictionary structures
# used in the yaml file
import sys
import yaml
from collections import OrderedDict
import json

import datetime


def datetime_handler(x):
    if isinstance(x, datetime.datetime):
        return x.isoformat()
    raise TypeError("Unknown type")

# Setup support for ordered dicts so we do not lose ordering
# when importing from YAML
_mapping_tag = yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG


def dict_representer(dumper, data):
    return dumper.represent_mapping(_mapping_tag, data.iteritems())


def dict_constructor(loader, node):
    return OrderedDict(loader.construct_pairs(node))

yaml.add_representer(OrderedDict, dict_representer)
yaml.add_constructor(_mapping_tag, dict_constructor)


input = yaml.load(open(sys.argv[1]))
output = open(sys.argv[2], 'w')
json.dump(input, output, indent=4, default=datetime_handler)