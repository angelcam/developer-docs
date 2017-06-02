Navigation: Pagination
SortOrder: 800

# Pagination

Some endpoints, like `cameras/`, employ pagination with the use of the `limit` and `offset` parameters. Each paginated
endpoint response has these fields:

- `count` - total number of items
- `next` - is link to next page of paginated result, can be null if reached end of set
- `previous` - is link to previous set of paginated result, can be null if `offset` is 0
- `results` - current paginated set

We recommend you always explicitly set the `limit` parameter to ensure you know how many results, per page, you'll get.
If you omit `limit`, the page will contain 100 items, at most.

### Setting the limit parameter

Let’s say you need to request all the cameras of the user, but only want 5 results at a time. Your `GET` would look
something like this:

    $ curl -H "Authorization: Bearer <your_token>" -X GET "https://api.angelcam.com/v1/cameras/?limit=5"

Note the `limit` parameter in this call is set to 5, so the response shows items 0 through 4.

### GET the next page of results

Next, let’s say you want to make a call to return the next page from the previous example. As you’ll see below, the
`offset` parameter in the following sample link is 5, so the next page of results will show items 5 through 9:

    $ curl -H "Authorization: Bearer <your_token>" -X GET "https://api.angelcam.com/v1/cameras/?limit=5&offset=5"

### How do I know if there are more pages?

When the response contain null value of `next`, you know that you've reached the end.
