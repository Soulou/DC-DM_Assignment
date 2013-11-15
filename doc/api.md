API Documentation
=================

Response codes
--------------

* GET
  * No error: 200 OK
  * Not found: 404
  * Invalid format: 406
* DELETE
  * No error: 204 No content
  * Not found: 404
* POST
  * No error: 201 Created
  * Invalid Request: 400
  * Invalid Requested Format: 406
  * Unprocessable Entity: 422
* PUT
  * No error: 200
  * Invalid Request: 400
  * Not found: 404
  * Invalid Requested Format: 406
  * Unprocessable Entity: 422
   
Invalid Request: The parameters don't have the good format
Invalid Requested Format: The `Accept` header is not managed by the service, see [Formats](.)
Unprocessable Entity: The parameters are incorrect

Formats
-------

XML and JSON may be queried according to the Accept header:
* 'Accept: application/json'
* 'Accept: application/xml'
Without this precision, the service will ansert with JSON

Parameters
----------

For POST/PUT requests the parameters must be encoded in JSON
and the header `Content-Type` must be set at
`application/x-www-form-urlencoded` or `applicaton/json`.

Error Handling
--------------

When an error occured, the following structured is sent:
```js
{
  "error": "reason"
}
```

Endpoints
----------

### Entity Location:

The following JSON object represents a Location. In the endpoints
definition, `#{Location}#` has to be replace by this kind of JSON
object.

```js
{
  "id": "0123456789",
  "name": "Eiffel Tower",
  "city": "Paris",
  "country": "France",
  "description": "Famous since the 1900 world expo.",
  "is_real": true,
  "picture": {
    "original": {
      "format": "1280x800",
      "url": "/public/system/1/2/3/4/eiffel.png"
    },
    "thumb": {
      "format": "100x100>",
      "url": "/public/system/1/2/3/4/eiffel.png"
    }
  },
  "links": {
    "self": "http://localhost:9202/locations/0123456789"
  }
}
```

> `GET /locations`

```js
[
  #{Location},
  #{Location},
  …
]
```

> `GET /locations/:id`

```js
#{Location}
```

> `GET /locations/search/:name`

```js
[
  #{Location},
  #{Location},
  …
]
```

> `POST /locations`

```js
#{Location}
```

> `PUT /locations/:id`

```js
#{Location}
```

> `DELETE /locations/:id`

→ Empty response
