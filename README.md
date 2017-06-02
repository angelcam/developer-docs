# Angelcam Developer docs

Sources for http://developers.angelcam.com, API and guides documentation, generated from Markdown and Swagger files.

## Running

To run Dapperdox developer website from this image:

* choose host machine port - Dapperdox runs on 3123 and it's best to use the same on host
* map your Dapperdox sources to `/dapperdox/` in container
* choose container meaningful name like 'developer-docs`

In words of commandline e.g.:

    $ docker run --rm --name developer-docs -p 3123:3123 -v ~/git/developer-docs/dapperdox_src:dapperdox_src:/dapperdox angelcam/develop-docs

## Configuration

Dapperdox running inside Docker container support configuration via environment variable only. Equivalent variable name to commandline option is found in [Dapperdox configuration guide](http://dapperdox.io/docs/configuration-guide).

By default specdir is set to `/dapperdox/specs` and assets to `/dapperdox/assets`. Because folders in `dapperdox_src/` have already these names you typically only map `/dapperdox/` to `dapperdox_src/`.

For example to change a specdir, set environment variable `SPEC_DIR` with `-e`:

    $ docker run --rm --name developer-docs -p 3123:3123 -v ~/git/developer-docs/dapperdox_src:dapperdox_src:/dapperdox -e SPEC_DIR /path/to/my/specdir angelcam/develop-docs
    
## Rebuild and push image

After every change in Markdown or Swagger file(s), you must rebuild and push image. From this repo directory:

    $ docker build -t angelcam/developer-docs .
    $ docker push
