# Design Notes for Grafeas Docker Compose

This is simple Docker Compose project to run Grafeas with a Postgres server.

# Postgres SQL Server

The Postgres SQL server Docker image is built from a standard Postgres 10.3 distribution with the following steps added:

1. An initialisation script is provided in the standard location for the Postgres Docker as per the installation guide [here](https://hub.docker.com/_/postgres/).
2. The default port 5492 is exposed in the container.
3. When executing the image it is necessary to provide a value for the 'admin' password for Postgres, namely for the account 'postgres' which is the default admin account. This is done by providing an environment variable POSTGRES_PASSWORD via the Compose file.

# Grafeas Server

The Grafeas server is a recent Alpine base image executing a special prebuilt version of the Grafeas server (a [GoLang](https://golang.org/) binary executable).

## Ensuring the Postgres Server is Running Before Starting Grafeas

Since the Grafeas server and the Postgres server are executed from the same Docker Compose file it is important that the database server is running and accepting connections before the Grafeas server attempts to connect since there is no retry logic in the Grafeas server.

Docker propose a number of best practices to achieve this [here](https://docs.docker.com/compose/startup-order/) and this project utilises the SH sell compatible ['wait-for'](https://github.com/eficode/wait-for) script.

### Parsing the Hostname and Port from the Config File

The database server details are configured in the Grafeas configuration file called 'config.yaml' and the following piece of shell script yanks out the server name and port number:

> grep -Eo "host:\s*\"(.+:[0-9]+)\"" config.yaml | cut -d \" -f2

### The 'start.sh' Script

This simple script performs the following actions:

1. Retrieves the server name and port number from the 'config.yaml' file.
2. Uses the 'wait-for.sh' script to check if the server at the specified location is accepting connections.
3. If it is then runs the Grafeas server.

## Building the Grafeas Server Executable

The Grafeas server is a [GoLang](https://golang.org/) executable build from the [Grafeas repository](https://github.com/grafeas/grafeas). 

I didn't want to have a dependency on building the full Grafeas project to be able to deploy a server so I took a bit of a shortcut/hack and simply used the existing [Dockerfile](https://github.com/grafeas/grafeas/blob/master/Dockerfile) from with the Grafeas repo to build me a working version of the Grafeas server and then I just used ```docker cp ...``` to extract the built binary file. 

If you want to use a more up to date version of Grafeas you will need to clone the Grafeas repo, build the Dockerfile, and copy the server file yourself and replace the [one](https://github.com/createk-design/grafeas-docker/blob/master/server/grafeas-server) in this repository.