import requests
url = 'https://api.angelcam.com/v1/events/'
payload = {'hash': '50yxnlu2o2'}
requests.post(url, json=payload)