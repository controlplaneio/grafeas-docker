# grafeas-docker

This is a Docker Compose project to provide a self contained instance of Google's [Grafeas](https://grafeas.io/) server using a Postgres SQL as the persistence layer.

## Getting Started

The quickest way to get started, if you just want a Grafeas server to
experiment with, is the Docker Compose method, below.

There is also a Makefile, which is working towards something that can be used
in production, but it isn't working yet.

### Prerequisites

You will require a current version of Docker and Docker Compose, and a means to
test the Grafeas server such as their
[Python](https://github.com/grafeas/client-python) or
[Go](https://github.com/grafeas/client-go) client libraries. Using cURL may be
sufficient for your needs, too..

### Installing

#### Using the Docker Compose Method

The Docker Compose file requires an environment file to pass in the passwords
for Postgres and Grafeas. They will get configured on first execution of the
application, and then used thereafter.

Create the `.env` file and generate passwords like so:

```
tee .env > /dev/null <<EOF
POSTGRES_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;)
GRAFEAS_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;)
EOF
```

Now build the images and run the containers:

```
$ docker-compose build
$ docker-compose up
```

The Grafeas server will now be exposed on ['localhost:8080'](localhost:8080).

#### Using the Makefile - \*\*WIP, broken\*\*

_WIP: If you put passwords into the \*PASSWORD\* vars in the Makefile, run `make
generate-db-init-script` and then `make run` it might work!_

Clone the repository and from within the root directory execute the following
sequence of commands:

* To build the Grafeas image and to generate the Postgres initialisation script run:
> make build

* If you have not set up the Grafeas network run:
> make run-prod-network

* To run the Grafeas server and the Postgres database run: 
> make run

There is also a utility script called 'run_local_postgres.sh' that will do the following:

1. Run the Postgres image locally (as 'postgres_local') and expose port 5432 on the Grafeas network.
2. Run the very useful [PGAdmin](https://www.pgadmin.org/) tool on port 8888 to allow debugging of Grafeas database transactions. 

## Built With

This software was built and tested on MacOS High Sierra using:

* Docker for Mac 18.03 CE
* Docker Compose 1.21

Subsequent modifications were built and tested on **Arch Linux** using:

* Docker 18.05.0-ce
* Docker Compose 1.22.0

...and used in workshop on CentOS 7 using:

* Docker 17.06.02
* Docker COmponse 1.11.2

## Dependencies

* The official [Grafeas](https://github.com/grafeas/grafeas) project

## Contributing

Pull requests and suggestions are welcome; please submit via GitHub.

## Versioning

No release version exists yet, use the 'master' branch.

## Authors

Colin Domoney [@colindomoney](https://twitter.com/colindomoney?lang=en)
Luke Bond [@lukebond](https://twitter.com/lukebond?lang=en)

## License

This software is released under the
[MIT licence](https://github.com/controlplaneio/grafeas-docker/blob/master/LICENSE)

## Acknowledgments

