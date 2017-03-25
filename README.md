# SocialStalk

To setup this project on c9:
* Install ruby on rails
* Restart psql server: `sudo service postgresql restart`
* Run `rake db:create` and `rake db:schema:dump`
* Follow https://gist.github.com/amolkhanorkar/8706915 to fix the problem below:
> `PG::Error: ERROR: new encoding (UTF8) is incompatible`
* Run `rake db:migrate`

======================================
     Solution to error above
======================================

Follow steps below to resolve the problem:

First, we need to drop template1. Templates can’t be dropped, so we first modify it so t’s an ordinary database:

        `UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';`

Now we can drop it:

        `DROP DATABASE template1;`

Now its time to create database from template0, with a new default encoding:

        `CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';`

Now modify template1 so it’s actually a template:

        `UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';`

Now switch to template1 and VACUUM FREEZE the template:

        `\c template1`

        `VACUUM FREEZE;`

Done!
