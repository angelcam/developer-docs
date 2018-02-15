SortOrder: 100
Navigation: Welcome

# Angelcam API

> If you have any questions please feel free to contact our API team via email at
> support@angelcam.com. Also, once you’ve gone through the document, we would love
> to hear your **[thoughts and feedback](https://goo.gl/forms/Gm2t7jxncfrTV4GG2)**.

Welcome! This document will help guide you through how to use Angelcam’s RESTful API. You’ll find that the
RESTful API is not difficult to use, but does require some understanding of certain concepts behind
Angelcam service.

To begin, you MUST contact Angelcam support before using the API to request both a client ID and secret, for
authorization, and an authorization grant type.

## Quick-start Guide

> This example assumes you will use the API to access cameras under your Angelcam account. If your service
> needs to access someone else's camera you will need to use more complicated
> [Authorization code grant type](authentication).

### Obtain the access token

You will need the client ID as well as the username and password of your Angelcam account. E.g. if your
client ID is `DBaJcGbAT2Tbvbrz0fLh1uRmYURprJAQPxwFsgoo` and your Angelcam account is `user@example.com` with
password `secret` the request would be

    $ curl -X POST https://my.angelcam.com/oauth/token/ -d "client_id=DBaJcGbAT2Tbvbrz0fLh1uRmYURprJAQPxwFsgoo&grant_type=password&username=user%40example.com&password=secret"

The API response should look like

    {"refresh_token": "aFBNWhoLnq7hSTEVII5ELd9g20NjxC", "scope": "read write", "access_token": "1CP9xR6tqpRHzaZxWcFAp3GtkFcXEQ", "expires_in": 36000, "token_type": "Bearer"}

### Verify the authorization worked

    $ curl -H "Authorization: Bearer 1CP9xR6tqpRHzaZxWcFAp3GtkFcXEQ" -X GET "https://api.test.angelcam.com/v1/me/"

You should see information about your account

    {"id":1234,"email":"user@example.com","first_name":"Keyshawn","last_name":"Jacobs","phone":"+1608494652"}

### Use the access token to access the API endpoints

    $ curl -H "Authorization: Bearer 1CP9xR6tqpRHzaZxWcFAp3GtkFcXEQ" -X GET "https://api.angelcam.com/v1/cameras/?limit=5"

See the reference section for available resources and corresponding endpoints.
