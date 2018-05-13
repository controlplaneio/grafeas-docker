# Building Grafeas

This document describes how to build and debug the Grafeas server on a local machine.

## Further Information

* [Grafeas Repo on GitHub](https://github.com/grafeas/grafeas)
* [Grafease Homepage](https://grafeas.io/)
* [Grafeas on Google Groups](https://groups.google.com/forum/#!forum/grafeas-users)

## Prerequisites

Here are a few observations I had whilst setting up my build environment on a MacBookPro with OSX High Sierra.

### Protocol Buffer Compiler

There is an unstated dependency on having a binary executable of the [Google Protocol Buffer](https://developers.google.com/protocol-buffers/) on the build machine. On a Mac this is easily satisfied as follows:

> brew install protobuf

### Setting up GoLang Correctly

I shamefully admit being a complete 'noob' to [GoLang](https://golang.org/) and I had a particular painful experience trying to get projects to build correct due to unmet dependencies resulting from an GOPATH variable not being set correctly, and the use of 'github.com' prefixed package names in the Grafeas repository.

I'd suggest an newcomer to GoLang read [this](https://golang.org/doc/code.html) to save many hours of frustration.

What I found to work well was set GOPATH to '/home/colind/go' and then to allow GoLang to simply do its magic and install everything in the default locations, rather than having to re-write the 'github.com' prefixed package paths. The end result is that everything you ever do with GoLang ends up in this home folder but on the plus side you remain sane. I found doing a Git checkout of the Grafeas repo into the 'github.com' folder worked well leaving me with the following directory structure:

```
~/go/src/github.com/grafeas/grafeas [master ↑·1|…4]
# ls -al
total 128
drwxr-xr-x  23 colind  staff   736B Apr 24 14:18 ./
drwxr-xr-x   4 colind  staff   128B Apr 24 12:11 ../
drwxr-xr-x   3 colind  staff    96B Apr 24 12:12 .circleci/
drwxr-xr-x  16 colind  staff   512B Apr 24 14:12 .git/
-rw-r--r--   1 colind  staff    23B Apr 24 12:12 .gitignore
drwxr-xr-x   3 colind  staff    96B Apr 24 12:12 .idea/
-rw-r--r--   1 colind  staff   306B Apr 24 12:12 AUTHORS
-rw-r--r--   1 colind  staff   1.1K Apr 24 12:12 CONTRIBUTING.md
-rw-r--r--   1 colind  staff   378B Apr 24 12:12 Dockerfile
-rw-r--r--   1 colind  staff   393B Apr 24 14:08 Dockerfile.build
-rw-r--r--   1 colind  staff    11K Apr 24 12:12 LICENSE
-rw-r--r--   1 colind  staff   1.2K Apr 24 12:12 Makefile
-rw-r--r--   1 colind  staff    13K Apr 24 12:12 README.md
drwxr-xr-x   3 colind  staff    96B Apr 24 12:12 case-studies/
-rw-r--r--   1 colind  staff   2.8K Apr 24 12:12 code-of-conduct.md
-rw-r--r--   1 colind  staff   1.5K Apr 24 12:12 config.yaml.sample
drwxr-xr-x   3 colind  staff    96B Apr 24 12:12 docs/
-rwxr-xr-x@  1 colind  staff   1.3K Apr 24 14:06 idle.sh*
drwxr-xr-x   4 colind  staff   128B Apr 24 12:12 samples/
drwxr-xr-x   4 colind  staff   128B Apr 24 12:12 server-go/
drwxr-xr-x   3 colind  staff    96B Apr 24 12:12 v1alpha1/
drwxr-xr-x   3 colind  staff    96B Apr 24 12:12 v1beta1/
drwxr-xr-x   7 colind  staff   224B Apr 24 12:12 vendor/
```

## Building Natively

Once the prerequisites have been met (and GOPATH smiles upon you) the easiest way to build Grafeas is to navigate to the following folder and execute the Go Build command as shown:

```
~/go/src/github.com/grafeas/grafeas/samples/server/go-server/api/server/main [master ↑·1|…5]
# go build -o ./grafeas-server .
✔ ~/go/src/github.com/grafeas/grafeas/samples/server/go-server/api/server/main [master ↑·1|…5]
# ls -al
total 29280
drwxr-xr-x   5 colind  staff   160B Apr 30 13:42 ./
drwxr-xr-x  11 colind  staff   352B Apr 24 12:12 ../
-rw-r--r--   1 colind  staff   1.5K Apr 24 12:14 config.yaml
-rwxr-xr-x   1 colind  staff    14M Apr 30 13:42 grafeas-server*
-rw-r--r--   1 colind  staff   1.5K Apr 24 12:12 main.go
```

The resultant ```grafeas-server``` executable takes a single parameter, namely a [config file](https://github.com/grafeas/grafeas/blob/master/config.yaml.sample) as follows:

```
./grafeas-server --config config.yaml
```

### Using the Makefile

Grafeas also includes a [Makefile](https://github.com/grafeas/grafeas/blob/master/Makefile) to build the codebase, however there are a number of steps in the makefile that aren't perfectly clear to me or at least seem to be unused.

In particular it was the recompilation of the Protocol Buffer code that seemed superfluous i.e.

```
.PHONY: grafeas_go
grafeas_go: v1alpha1/proto/grafeas.pb.go
```

This code doesn't appear to be used anywhere.

## Building the Dockerfile

The easiest way to just get Grafeas running is to use the [Dockerfile](https://github.com/grafeas/grafeas/blob/master/Dockerfile) in the Grafeas repo which will build Grafeas, and execute it using memory store and binding to local port 8080.