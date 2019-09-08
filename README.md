# Makers Program

[![Maintainability](https://api.codeclimate.com/v1/badges/3faf1e5fc78d2ea309b6/maintainability)](https://codeclimate.com/github/ProyectoIntegrador2018/makers/maintainability)

This is the repository for "Makers Program" for Tec de Monterrey. This project will aid in promoting and incrementing the protoyping capabilities for the Tec community. It provides a platform to consult shared spaces and devices within the Monterrey campus for prototype fabrication.

## Table of contents

* [Client Details](#client-details)
* [Environment URLS](#environment-urls)
* [Team](#team)
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
| Aldo Cervantes             | A01039261@itesm.mx | Desarrollo |
| Diego Astiazarán | A01243969@itesm.mx | Desarrollo |
| Erik Torres         | A01196362@itesm.mx | Desarrollo |
| Héctor Morales             | A01193139@itesm.mx | Desarrollo |

### Management tools

You should ask for access to this tools if you don't have it already:

* [Github repo](https://github.com/ProyectoIntegrador2018/makers)
* [Backlog](https://github.com/ProyectoIntegrador2018/makers/projects)
* [Heroku](https://makers-program.herokuapp.com/)
* [Documentation](https://drive.google.com/open?id=18KPPQ1VZwSyOb2UREPyWXmzGm2MxcWDy)

## Development

### Setup the project locally

To run the project, you will need to make sure you have [Docker](https://docker.com) installed on your machine.

After installing, you can follow this simple steps:

1. Clone this repository into your local machine

```bash
$ git clone git@github.com:ProyectoIntegrador2018/makers.git
```

2. Navigate to the `makers/` directory and run:

```bash
$ docker-compose build
```

3. Once the Docker image is built:

```bash
$ docker-compose run web bash
```

This command will open a bash session inside the container, from which you can interact directly with the rails application.

4. Set up the database inside the web container

```bash
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

You only need to follow the previous steps the first time you build the app locally, but some of the steps can and should be reused when configuration and database schema changes.

### Running the stack for Development

1. Once the database is setup and populated, you can exit the web container with `Ctrl + z` and run the following command to start the rails application:

```bash
$ docker-compose up
```

It may take a while before you see anything. Once you see an output like this:

```
web_1   | => Booting Puma
web_1   | => Rails 5.2.2 application starting in development on http://0.0.0.0:3000
web_1   | => Run `rails server -h` for more startup options
web_1   | => Ctrl-C to shutdown server
web_1   | Listening on 0.0.0.0:3000, CTRL+C to stop
```

This means the project is up and running and the web app can be used at `localhost:3000`.

### Stop the project

Use `Ctrl + c` on the terminal window in which the rails server is open to stop the project.

If you want to stop every docker process related to the project, you can run the following command from the root (`makers/`) directory:

```bash
$ docker-compose stop
```

### Running specs

To run specs, you can enter the web container with `docker-compose run web bash` and then:

```bash
$ rspec
```

Or for a specific file:

```
$ rspec spec/models/user_spec.rb
```
