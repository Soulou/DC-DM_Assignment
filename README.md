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

DAO Client
----------

> `rake daoclient:exec`

### Language

* `GETALL`
* `GET id`
* `FINDBYNAME name`
* `CREATE attr1 value1 attr2 value2 …`

_Note_: The application uses an interface to GNU readline to provide an history in the commands
you run.


API Server
----------

To run the server: `rackup -p $PORT`


### Some explanations about the file of the project

* `Gemfile`: Define the dependencies of the application
* `Gemfile.lock`: Generated by the command `bundle install`, contains the dependency tree
* `Procfile`: Define how to run the server on a PaaS like Appsdeck or Heroku
* `Rakefile`: Define some "batch" tasks which can be run
* `config.ru`: Specify a standard way to launch the application as a Rack-compliant web service
* `mongoid.yml`: Configuration of mongoid, the gem used to connect to a MongoDB database
