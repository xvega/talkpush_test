# README

### Problem
We made a google form asking for candidate to fill in their details for a job application. The form is linked to a google sheet, so once the form is filled and submitted, answers will appear in the google sheet.

We would like you to make a rails app that would check the GoogleSheet frequently, or if you want you can just make a button to force the app to check the google sheet. For every new row detected since the last update, you can make an API call to the Talkpush candidate function, so that we create a candidate with the GoogleForm information in our system. If the candidate is properly created you will get a status 200 response code and an email and sms to the candidate details will be sent.

Note: In this project I'm using docker and docker-compose. Hopefully you won't need to worry about dependencies more than having docker installed on your machine. The container is using postgresql, ruby 2.6.5 and Rails 6.0.

# Important:

I'm using rails `credentials` for encrypting and safely storing Talk Push API keys and other sensitive data, so there's a file in the `.gitignore` called `master.key`. For Google API I'm using a `config.json` file that I didn't want to upload to this repo. If you need those files please contact me: xabi1309@gmail.com for further information.

# System dependencies:
 - Docker
 - docker-compose
 
# How to run the application:

1. Clone the git repo:
     ```sh
    git clone git@github.com:xvega/talkpush_test.git
    ```

2. Build the container:
    ```sh
    docker-compose build
    ```
3. Create the db (if it doesn't exist) and run the migrations:
    ```sh
    docker-compose run web rails db:create
    docker-compose run web rails db:migrate
    ```
4. Run the application:
    ```sh
    docker-compose up -d
    ```
5. To run the application in dettached mode: 
    ```sh
    docker-compose up -d
    docker attach talk_push_test_app_web_1
    ```
    Note: `talk_push_test_app_web_1` comes from running `docker ps` and then copying the name of the web container under `NAMES`
6. If you want to access rails console:
    ```sh
    docker-compose exec web rails console
    ```
# How to run tests

1. Running the whole suite
    ```sh
    docker-compose run -e "RAILS_ENV=test" web rspec spec/
    ```
2. Running individual tests:
    ```sh
    docker-compose run -e "RAILS_ENV=test" web rspec spec/services/talkpush_api_spec.rb
    ```
# Developer's useful information:

If you need to access the cronjob log do the following:
    1. Run `docker ps`
    2. Copy the `Container ID` for the cronjob
    3. `docker exec -it {CONTAINER_ID} bash`
    4. Run this line `cat /var/log/cron.log`
