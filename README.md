# README

## Ruby Version

`2.5.0`

## System Dependencies

* PostgreSQL 9.6.x.

#### Linux:

To configure postgres cleanly
```
sudo apt-get purge -f libxml2-dev
sudo apt-get clean
sudo apt-get update
sudo apt-get install libxml2 libxml2-dev
```

## Setup project

```
bundle install
```

## Seeding

To start with a fresh database, run the following:

```
rake db:drop db:create db:migrate
```

Before seeding add your twilio phone number in place of `phone_number`

```
$ rake db:seed
```


