Navigation: Authentication
SortOrder: 300

# Authentication

All API requests must be made over HTTPS. Calls made over plain HTTP will fail. Additionally, all request must be
authenticated. Angelcam API authentication is based on OAuth2 Bearer tokens.

We support two different authentication workflows (_grant types_ in terms of OAuth):

* You ask your users for their Angelcam usernames and passwords (_resource owner password-based_ in terms of OAuth)
* You ask Angelcam and we authenticate your users, similar to how Google or Facebook works if you choose "Sign-in using
  Google/Facebook" (_authorization code_ in terms of OAuth)

Both authentication types result in the same - you exchange username/password or authorization code by calling
`/oauth/token/` endpoint for access token. All API calls must supply this access token with
`Authorization: Bearer <your_access_token>` as header. For example, with cURL commandline tool, your request would
contain something like this:

    $ curl -H "Authorization: Bearer <your_token>" -X GET  "https://api.angelcam.com/v1/cameras/?limit=5"

These access tokens also have a limited-time validity (usually 10 hours) and you’ll have to [ask for new access token
using refresh token](#introduction/authentication/refreshing-access-token-with-refresh-token) when current access token
expires.

An authenticated user can use `me/` to ask for account details including email, first name, last name, etc.

## Password grant

![Password grant type sequence diagram](https://www.lucidchart.com/publicSegments/view/d6b6d907-2ba1-4476-bbdf-18cceab89d48/image.png)

Password grant type is a more basic and easier way for authorization, but is less safe for Angelcam users. With this
grant type, it's you who asks for the credentials in the UI and it's your app that calls `oauth/token/` to exchange user
credentials for the bearer token.

Be aware! DO NOT save the password or username of any user under any circumstances. To implement a "Remember me"
checkbox in your app, save the refresh token instead and ask for a new access token during the application startup
using the `oauth/token/` endpoint.

## Authorization code grant

![Authorization code grant sequence diagram](https://www.lucidchart.com/publicSegments/view/a9284b28-7c6d-4441-be56-20df4dbbe4fa/image.png)

The authorization code grant should be very familiar if you've ever signed into a web app using your Facebook or Google
account.

Authorization code grant type is safer but more difficult to implement and requires the presence of a web browser on
the user's machine to display an Angelcam account sign-in web page. When users submit the form and confirm that your
app will have access to their data, we check their credentials and redirect them back to a URL of your app
(`redirect_uri`), which you have specified. This process works in the very same way as when you click a "Sign-in using
Google/Facebook" button.

Your app sends GET to `https://api.angelcam.com/oauth/authorize/` with the following query parameters:

* `response_type` (required)- authorization grant type with fixed value `code`
* `client_id` (required)- your client ID, obtained from Angelcam
* `redirect_uri` (required)- URI within your app where users will be redirected after a successful authentication. You
  must ask Angelcam to whitelist chosen `redirect_uri` for your client ID otherwise you will get a 400 response with
  "Mismatching redirect URI" error.
* `scope` (required) - space delimited list of scopes currently with the fixed value `read`
* `state` (optional) - value that serves as [CSRF](https://en.wikipedia.org/wiki/Cross-site_request_forgery) token.
  This parameter is optional but highly recommended. You should store the value of the CSRF token and compare the
  `state` returned by Angelcam with the value you sent in the original request.

Here is an example of how the resulting request would look like:

    GET https://api.angelcam.com/oauth/authorize/?response_type=code&client_id=XU0aXeP1299oS48KnZmxhqWUR928jsmFKosdrfMS&scope=read&state=my_csrf_secret&redirect_uri=http://a948dfc1.ngrok.io

All of these parameters will be validated by the authorization server. The users will then be asked to log in to
approve your app.

[Click to see picture of *OAuth screen asking for user approval*](https://drive.google.com/file/d/0ByFjd1QsTrU0cjk1am12bFRiQjg/view?pli=1)

If your `redirect_uri` is for example `https://api.mysuperapp.com/oauth/authorized/`, the resulting URL we redirect
your users to will be:

    https://api.mysuperapp.com/oauth/authorized/?state=my_csrf_secret&code=hTmV8rbgz2TR2DFr1jha2aOTdMKFHY.

Note these query parameters were appended to redirect URI:

* `state` - the state parameter sent in the original request. You should compare this with the value you previously
  saved to ensure that the authorization code obtained through requests were made by the same client
* `code` - the authorization code that you will exchange at `oauth/token/` for a bearer token

## Refreshing access token with refresh token

The granted access_token is valid for expires_in seconds only. By default, it's set at 36000 seconds (10 hours) but you
must always keep this value in mind and refresh the access token before it expires. A common practice of how to manage
expiration is to refresh a token when you get a `401 Unauthorized` from any endpoint since all API endpoints must be
authenticated.

Example of unauthorized response:

    HTTP/1.1 401 Unauthorized
    Date: Thu, 27 Apr 2017 10:41:58 GMT
    Content-Type: application/json
    WWW-Authenticate: Bearer realm="api"

    {"status":401,"title":"not_authenticated","detail":"Authentication credentials were not provided."}

A new `access_token` can be obtained using a `refresh_token` when the current one expires. A `refresh_token` has no
expiration date but it can only be used once. A new `refresh_token` is issued when the client refreshes the
`access_token`, which causes all previous tokens to become invalid.

To refresh the `access_token`, send another `POST` request to `oauth/token/` endpoint with:

* `refresh_token`,
* `client_id`,
* `grant_type` with `refresh_token` value
* `username` and `password` aren't required this time

The server will then generate a fresh `access_token` and a new `refresh_token`.

A refresh token can be invalidated by the `oauth/token-revoke/` endpoint. This usually occurs when a user logs out of
your app or is performed by the Angelcam support team, upon request by the user or due to security concerns. In any
case, you will need to then ask the user to grant authorization to your app again.
