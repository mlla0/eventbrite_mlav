# eventbrite exercice (thp week 6, day 1)

## made in pair programming by maud lévy :fried_shrimp: & antoine vercoutère :poultry_leg:

### how to use

1. git clone the repository to your computer
2. run the `bundle install` command
3. run the `rails db:create` command
4. run the `rails db:migrate` command
5. if you run `rails db:seed`, your web browser will pop up and show all the emails the app sent
6. you can also run the `rspec` command, that should return a well tested app 

### the tables that compose the app

this app is composed of three tables in its database :

** the `users` table, which contains the followings coloumns: **
- email *(a string)*
- encrypted_password *(a string)*
- first_name *(a string)*
- last_name *(a string)*
- description *(a text)*

** the `events` table, which contains the followings coloumns: **
- start_date *(datetime, should be in the future)*
- duration *(integer, should be a multiple of 5)*
- title *(between 5 and 140 characters)*
- description *(between 20 and 1000 characters)*
- price *(between 1 and 1000 $)*
- location *(anywhere on the planet earth, our mother land)*
- admin_id *(a user)*

** the `attendances` table, which contains the followings coloumns: **
- strip_customer_id *(a string)*
- participant_id *(a user)*
- event_id *(an event)*

### rspec

we put tests on every models, especially for the event model, which contains a lot of validations, and two methods for validations.

### mailers

emails are sent when a user is created, to welcome him/her. 

also when a user attends an event, the admin of the event receives an email.

:kiss: