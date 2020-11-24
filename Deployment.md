# Makers Program: Deployment

The Makers Program repository is currently set-up to automatically deploy any changes made to the master branch onto the staging environment: [Heroku Staging](https://makers-program-staging.herokuapp.com/), and subsequently to production after approval. This instructions are tailored specifically for anyone interested in deploying the application into a new Heroku instance.

## Table of contents

* [Preconditions](#Preconditions)
* [Clone or update repository](#Clone-or-update-repository)
* [Deploying to Heroku](#Deploying-to-Heroku)
* [Additional references](#Additional-references)

### Preconditions
Having the following tools installed and configured:
- Git ([Instrucciones](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))
- Heroku CLI ([Instrucciones](https://devcenter.heroku.com/articles/heroku-cli#download-and-install))

### Clone or update repository
If you don't have a copy of the repository, you will have to clone it first:
```bash
$ git clone https://github.com/ProyectoIntegrador2018/makers.git
```

Run the following command to make sure everything is up to date:
```bash
$ git status
```

You should see the following message:
```
On branch master
Your branch is up-to-date with 'origin/master'.
```

If not, make sure your working directory is clean and that the local branch is up to date:
```bash
$ git pull origin master
```

### Deploying to Heroku

Make sure you are logged in to Heroku on your terminal session. Run the following command to setup your environment with Heroku:
```bash
$ heroku create
```

To push deploy the current master branch to Heroku, run:
```bash
$ git push heroku master
```

Finally, run the database migrations on your Heroku application:
```bash
$ heroku run rake db:migrate
```

### Environment Variables
Makersprogram was setup using Outlooks SMTP to send email, if you want to use the same provider, just make sure to include the environment variables `TEC_USERNAME` and `TEC_PASSWORD` in your production environment.
<br>
If you want to review the mailer configuration or wish to change the provider head to [production.rb](config/environments/production.rb) and update `config.action_mailer.smtp_settings` to match your own configuration.

### Additional references
For additional references, please visit the following support page from Heroku: [Getting Started on Heroku with Rails 5.x](https://devcenter.heroku.com/articles/getting-started-with-rails5)
