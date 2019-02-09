# Makers Program

This is the repository for "Makers Program" for Tec de Monterrey. This project will aid in promoting and incrementing the protoyping capabilities for the Tec community. It provides a platform to consult shared spaces and devices within the Monterrey campus for prototype fabrication.

## Table of contents

* [Client Details](#client-details)
* [Environment URLS](#environment-urls)
* [Team](#team)
* [Management resources](#management-resources)
* [Setup the project](#setup-the-project)
* [Running the stack for development](#running-the-stack-for-development)
* [Stop the project](#stop-the-project)
* [Running specs](#running-specs)


### Client Details

| Nombre                         | Email                    | Rol                 |
| ------------------------------ | ------------------------ | ------------------- |
| Azael Jesús Cortés Capetillo   | azael.capetillo@tec.mx   | Cliente             |
| Julio Noriega Velasco          | jnoriega@tec.mx          | Asociado al Cliente |
| Alejandra Díaz de León Lastras | adiazdeleon@tec.mx       | Asociado al Cliente |


### Environment URLS

* **Production** - [Heroku Production](https://makers-program.herokuapp.com/)
* **Development** - [Heroku Staging](https://makers-program-staging.herokuapp.com/)

### Team

| Name                              | Email              | Rol        |
| --------------------------------- | ------------------ | ---------- |
| Hector Rincón de Alba             | A01088760@itesm.mx | Desarrollo |
| Jesús Alejandro Galván Villarreal | A01192562@itesm.mx | Desarrollo |
| Ana Karen Beltrán Murillo         | A01192508@itesm.mx | Desarrollo |
| Abraham Pineda García             | A00759440@itesm.mx | Desarrollo |

### Management tools

You should ask for access to this tools if you don't have it already:

* [Github repo](https://github.com/ProyectoIntegrador2018/makers)
* [Backlog](https://github.com/ProyectoIntegrador2018/makers/projects)
* [Heroku](https://makers-program.herokuapp.com/)
* [Documentation](TBD)

## Development

### Setup the project

To run the project, you will need to make sure you have [Ruby](http://www.ruby-lang.org/en/) 2.5.3 and [Ruby on Rails](https://rubyonrails.org) 5.2.2 or later installed on your development environment. You can find instructions to install both of them in [ GoRails ](https://gorails.com/setup/). You will also need [PostgreSQL](https://www.postgresql.org) for the database.

After installing, you can follow this simple steps:

1. Clone this repository into your local machine

```bash
$ git clone git@github.com:ProyectoIntegrador2018/makers.git
```

2. Fire up a terminal and run:

```bash
$ bundle install
```

3. You will need to setup and migrate the database:

```bash
$ rails db:setup
$ rails db:migrate
```

### Running the stack for Development

1. Fire up a terminal and run:

```bash
$ rails server
```

It may take a while before you see anything. Once you see an output like this:

```
web_1   | => Booting Puma
web_1   | => Rails 5.2.2 application starting in development on http://0.0.0.0:3000
web_1   | => Run `rails server -h` for more startup options
web_1   | => Ctrl-C to shutdown server
web_1   | Listening on 0.0.0.0:3000, CTRL+C to stop
```

This means the project is up and running.

### Stop the project

In order to stop crowdfront as a whole you can run:

```
% CTRL+C
```

### Running specs

To run specs, you can do:

```bash
$ rspec
```

Or for a specific file:

```
$ rspec spec/models/user_spec.rb
```