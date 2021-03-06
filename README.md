Distributed Computing & Data Management Assignment
=================================================

A MongoDB must be running. In development we are looking at `127.0.0.1:27017`,
in any other environment, the environment variable `MONGO_URL` has to be defined.

Tasks
-----

* `rake db:seed` Import some data in the database
* `rake console` Interactive console in the environment of the application (Access to database)
* `rake daoclient:exec` Interactive prompt to use the DSL of the DAO
* `rake daoclinet:exec [file]` Interpret the file with the DSL
* `rake restclient:exec <service_URL>` Same as DAO client but for a webservice
* `rake restclient:exec <service_URL> [file]`

DAO Client
----------

> ### Interactive client
> `rake daoclient:exec`
> ### Script client
> `rake daoclient:exec [file]`
-> _Note_: One example could be found in the 'examples' directory

Rest Client
-----------

> ### Interactive client
> `rake restclient:exec <service_URL>`
> ### Script client
> `rake restclient:exec <service_URL> [file]`

### Language

* `GETALL`
* `GET <id>`
* `FINDBYNAME name`
* `CREATE attr1, "value1", attr2, "value2", …`
* `UPDATE <id>, attr1, "value1", …`
* `DELETE <id>`

> The keywork 'last' can substitute an ID and it represents the last item which has been get/create
> i.e.:
> * `GET <id>`
> * `UPDATE last, name, "New name"`
> * `DELETE last`

_Note_: The application uses an interface to GNU readline to provide an history in the commands
you run.

API Server
----------

To run the server: `rackup -p $PORT`

API Documentation
-----------------

[Go to the API documentation](../master/doc/api.md)

### Some explanations about the file of the project

* `Gemfile`: Define the dependencies of the application
* `Gemfile.lock`: Generated by the command `bundle install`, contains the dependency tree
* `Procfile`: Define how to run the server on a PaaS like Appsdeck or Heroku
* `Rakefile`: Define some "batch" tasks which can be run
* `config.ru`: Specify a standard way to launch the application as a Rack-compliant web service
* `config/mongoid.yml`: Configuration of mongoid, the gem used to connect to a MongoDB database
