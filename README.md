# grafeas-docker

This is a Docker Compose project to provide a self contained instance of Google's [Grafeas](https://grafeas.io/) server using a Postgres SQL as the persistence layer.

## Getting Started

### TODO

* Two modes of building
* Create the network interface first

### Prerequisites

You will require a current version of Docker and Docker Compose, and a means to test the Grafeas server such as their [Python](https://github.com/grafeas/client-python) or [Go](https://github.com/grafeas/client-go) client libraries.

### Installing

The project was originally written as a Docker Compose project with two containers; the Grafeas server and its associated Postgres database. However I then added a Makefile to make the build/run process more in line with the way other projects in this engagement were built. It should be possible to use either method to build and run, as follows:

#### Using the Docker Compose Method

Clone the repository and from within the root directory execute:

* > docker-compose build
* > docker-compose up

The Grafeas server will now be exposed on ['localhost:8080'](localhost:8080).

#### Using the Makefile

Clone the repository and from within the root directory execute the following sequence of commands:

* If you have not set up the Grafeas network run:
> make run-prod-network

* To build the Grafeas image and to generate the Postgres initialisation script run:
> make build

* To run the Grafeas server and the Postgres database run: 
> make run

There is also a utility script called 'run_local_postgres.sh' that will do the following:

1. Run the Postgres image locally (as 'postgres_local') and expose port 5432 on the Grafeas network.
2. Run the very useful [PGAdmin](https://www.pgadmin.org/) tool on port 8888 to allow debugging of Grafeas database transactions. 

## Built With

This software was built and tested on MacOS High Sierra using:

* Docker for Mac 18.03 CE
* Docker Compose 1.21

## Dependencies

* The official [Grafeas](https://github.com/grafeas/grafeas) project

## Contributing

Pull requests and suggestions are welcome; please submit via GitHub.

## Versioning

No release version exists yet, use the 'master' branch.

## Authors

Colin Domoney [@colindomoney](https://twitter.com/colindomoney?lang=en)

## License

This software is released under the [MIT licence](https://github.com/createk-design/grafeas-docker/blob/master/LICENSE)

## Acknowledgments

