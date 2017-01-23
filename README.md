# README

To Get Started:

* Create duplicate of "database_example.yml" file in "/config"

* Rename duplicate file to "database.yml", keeping "database_example.yml" in tact

* Replace username in "database.yml" with you local root username and password with your local PostgreSQL password (if password is not required, delete "password" placeholder).

* rails g rspec:install (add '--format documentation' to .rspec file if desired)

* Terminal should read:
      create  .rspec
       exist  spec
    identical  spec/spec_helper.rb
    conflict  spec/rails_helper.rb
    Overwrite /Users/fariya/Desktop/whelp/spec/rails_helper.rb? (enter "h" for help) [Ynaqdh] n
    ** IMPORTANT: Enter 'N' to skip Overwrite of 'rails_helper.rb'**

* Run "postgres -D /usr/local/var/postgres"

* Run "rake db:create db:migrate"

* Run "rails s" in terminal/command line

* ...
