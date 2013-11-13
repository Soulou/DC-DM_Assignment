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

API Server
----------

To run the server: `rackup -p $PORT`


