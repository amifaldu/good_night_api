# good_night_api
This application only implemented APIs, will be used to sleep tracking of following users.
### Getting Started
Project setup for development and testing purposes.
### Prerequisites
* Ruby version
  - ruby 3.0.0p0
* Rails version
  - Rails 7.0.5
* Testing framework
  - RSpec
## Setup
- Clone this repository
```
$ git clone https://github.com/amifaldu/good_night_api.git
```
- Install a compatible version of PostgreSQL
```
$ cd good-night-api
```
- Initialize a new gemset (if using RVM) then install bundler
```
$ gem install bundler
```
- Install the application dependencies
```
$ bundle install
```
#### Database Configuration
*PostgreSQL* used as database for this application.
> Make sure PostgreSQL is installed on your machine and you have set up the  `database.yml` file correctly

- Database creation
```
$ rails db: create
```
- Tables migration
```
$ rails db: migrate
```

#### Running Tests

Test cases written using *RSpec*

Run test cases using this command

```
$ bundle exec rspec
```

All the tests should be *GREEN* to pass all test cases
```
$ rails s
```

- Check the application on the browser, open any browser of your choice, and hit the following in the browser URL *http://localhost:3000/*


```
localhost:3000
```
## APIs documentation with [Postman](https://www.postman.com/)

- [Documentation](https://www.postman.com/amifaldu/workspace/good-night-demo/collection/1224355-1df93337-c86b-4da8-9451-6a4cb1895d9e?action=share&creator=1224355)

- [APIs List](https://github.com/amifaldu/good_night_api/wiki/API-LIST)



## Author

**Ami Faldu** - [GitHub profile](https://github.com/amifaldu)
