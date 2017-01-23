# README

To Get Started:

* Create duplicate of "database_example.yml" file in "/config"

* Rename duplicate file to "database.yml", but keep "database_example.yml" as is. ("database.yml" is included in the .gitignore but will need to be configured for your local PostgreSQL).

* Replace username in "database.yml" with you local root username and password with your local PostgreSQL password (if password is not required, delete "password" placeholder).

* Run "rake db:create db:migrate" in terminal/command line to set up local app database.


* Terminal should read:
      create  .rspec
       exist  spec
    identical  spec/spec_helper.rb
    conflict  spec/rails_helper.rb
    Overwrite /Users/fariya/Desktop/whelp/spec/rails_helper.rb? (enter "h" for help) [Ynaqdh] n
    ** IMPORTANT: Enter 'N' to skip Overwrite of 'rails_helper.rb'**

* Run "postgres -D /usr/local/var/postgres"

* Run "rails s" in terminal/command line to fire up local server.


* Open your favorite internet browser and enter 'localhost:3000' into the url to confirm that you're good to go!
