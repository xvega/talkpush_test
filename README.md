# README

Problem: We made a google form asking for candidate to fill in their details for a job application. The form is linked to a google sheet, so once the form is filled and submitted, answers will appear in the google sheet.

We would like you to make a rails app that would check the GoogleSheet frequently, or if you want you can just make a button to force the app to check the google sheet. For every new row detected since the last update, you can make an API call to the Talkpush candidate function, so that we create a candidate with the GoogleForm information in our system. If the candidate is properly created you will get a status 200 response code and an email and sms to the candidate details will be sent.


In this project I'm using docker and docker-compose. To run the application:

Steps coming soon :D 

* Ruby version:

2.6.5

* Rails version: 

6.0.0

* System dependencies:

Docker and docker-compose

* Configuration

docker-compose build

docker-compose run web rails webpacker:install

docker-compose up

* Database creation

docker-compose run web rails db:create

* Database migrations

docker-compose run web rails db:migrate


