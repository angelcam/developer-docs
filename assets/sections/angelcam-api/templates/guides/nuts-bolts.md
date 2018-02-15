Navigation: Nuts & bolts
SortOrder: 200

# Nuts & bolts

## Plain JSON

The RESTful API runs over HTTP/1.1 and communicates using plain `application/json`.

## Trailing /

Lastly, please keep in mind that all endpoint URLs require a trailing slash (`/`). For example,
`cameras/282929/recording`, will result in a "404 Not Found". The correct URL in this case, with a trailing slash, is
`cameras/282929/recording/`.

## Caching

The API doesn't include any additional caching features, besides what is implied by the protocol layer.

## Resource Embedding and Field Fetching

This API doesn't support the embedding of related resources, nor client-driven field fetching.
