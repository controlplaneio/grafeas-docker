# Grafeas Examples

## Python Client

### Installation

I built the test code in the 'python' folder using the following:

* Python 3.6 (installed via Brew on MacOSX)
* [virtualenv](https://virtualenv.pypa.io/en/stable/) was used to create a sandboxed environment for the project dependencies
* The 'swagger_client' is installed by cloning the repo [here](https://github.com/grafeas/client-python/tree/master/v1alpha1) and running the ```setup.py``` script from within the folder using:
```python ./setup.py```

I installed the [sample Python code](https://github.com/grafeas/client-python) from the Grafeas project and used that as a starting point, and used the sample code in the [README.md](https://github.com/grafeas/client-python/blob/master/v1alpha1/README.md) as the starting point for exploration.

### Observations

The working example didn't work for me, actually managing to crash the Grafeas server. In fact the server seemed relatively easy to crash, even a slightly malformed request, or missing parameter could elicit a 'segmentation fault' on the server side.

The [grafeas.py](https://github.com/createk-design/grafeas-docker/blob/master/examples/python/grafeas.py) test file attempts to create a simple note and occurrence referencing that note and insert them into a project. This gives an error that the project does not exist (obviously) but then does not create the project, nor is the an option to create a project in the API. 
 
The [test suite](https://github.com/grafeas/client-python/blob/master/v1alpha1/test/test_grafeas_api.py) shows code to perform tests of the API but all the methods are currently just empty placeholders. 

My thought is that the 'swagger_client' has not been updated against the current API supported by the server. For example there clearly exists server side code to 'CreateProject' however this is not mirrored in the Python client. The last update to this repo was in October 2017.

## GoLang Client

### Installation
