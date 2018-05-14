Happy Store API Server
============================

# Structure
It is tradionally Rails API server. I developed with ruby v2.5.0 and rails v5.2

You can see the domain structure like below.

      Domain
        └── Category
                └── Entity
                └── Hierarchy
                └── Unit (for join with Product)
        └── PriceLine
                └── Entity
                └── Unit (for join with Product)
        └── Product
                └── Entity
                └── Searcher
        └── Sale

# Setup application

## Rails
First, Install the gems required by the application:

	bundle

Second, Execute sql on structure.sql in db folder.

(If you need dummy data, you can execute a task for creating the data)

	rake db:seed:dummy:create 

## Start Application
Start the application with below command.

	rails s

## Testing
You can test this application with below command.

You can also see test codes in the test folder.

	rails test

## API document
Enter the below link.

This API document page is created by rails-apipie gem.

https://github.com/Apipie/apipie-rails

	http://localhost:3000/apipie

