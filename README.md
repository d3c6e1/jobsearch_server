# jobsearch_server

## __dart: 2.7.2__

__Setting Up a Database__
```sql
CREATE DATABASE jobsearch;
CREATE USER dbuser WITH createdb;
ALTER USER dbuser WITH password 'qaz';
GRANT all ON database jobsearch TO dbuser;
```

Next, run the following commands:
```
aqueduct db generate
aqueduct db upgrade
```

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).