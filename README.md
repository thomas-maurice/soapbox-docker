# soapbox-docker

Deploys an instance of Soapbox with the `rebased` backend. Docker image available on [Docker Hub](https://hub.docker.com/r/mauricethomas/soapbox-docker). A new version of the image is rebuilt automatically

## Build the image

`docker build -t mauricethomas/soapbox-docker .`

## Get the image from dockerhub

```
docker pull mauricethomas/soapbox-docker
```

## Generate a config file

Run the image `docker run -it mauricethomas/soapbox-docker bash`, and create a new config file `mix pleroma.instance gen`. Then copy the `/opt/pleroma/config/generated_config.exs` and save it outside the image as `prod.secret.exs`, you will need this to start yout instance.

## Prepare the database

Create the db and user like so

```sql
CREATE USER pleroma WITH ENCRYPTED PASSWORD 'pleroma';
CREATE DATABASE pleroma OWNER pleroma;
\c pleroma;
CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

## Run a production instance

You need to run the container with the `prod.secret.exs` file mounted at `/opt/pleroma/config/prod.secret.exs`, db migrations should be run automatically.

You need to mount a directory to `/opt/pleroma/uploads` to persist the uploads from the users, this group should be owned by `998:998`

## Run locally for testing

Run `docker-compose up`, then `./pleroma.sh`

Your container will be acessible at `https://social.localhost`

:warning: DO NOT USE THE INCLUDED `prod.secret.exs` FILE IN PRODUCTION DEPLOYMENT, GENERATE A NEW ONE!

## Create the admin user

I refer you to the [soapbox docs](https://soapbox.pub/install/), but basically
`MIX_ENV=prod mix pleroma.user new <username> <your@emailaddress> --admin`

## Administrating your instance

When logged as the admin you can access to the soapbox admin interface: https://social.localhost/soapbox/admin
You an access the pleroma interface at [https://<yourdomain.com>/pleroma/admin](https://social.localhost/pleroma/admin)
