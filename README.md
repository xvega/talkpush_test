# README

### Problem
We made a google form asking for candidate to fill in their details for a job application. The form is linked to a google sheet, so once the form is filled and submitted, answers will appear in the google sheet.

We would like you to make a rails app that would check the GoogleSheet frequently, or if you want you can just make a button to force the app to check the google sheet. For every new row detected since the last update, you can make an API call to the Talkpush candidate function, so that we create a candidate with the GoogleForm information in our system. If the candidate is properly created you will get a status 200 response code and an email and sms to the candidate details will be sent.

Note: In this project I'm using docker and docker-compose. Hopefully you won't need to worry about dependencies more than having docker installed on your machine. The container is using postgresql, ruby 2.6.5 and Rails 6.0.

# Important:

I'm using rails `credentials` for encrypting and safely storing Talk Push API keys and other sensitive data, so there's a file in the `.gitignore` called `master.key` that you would need from me. For Google API I'm using a `config.json` file that I didn't want to upload to this repo because it can be generated by yourself.

# Generate your own Google Credentials:

-  The first time you run the app you're going to be asked to click a link to get a code in the browser that you will paste in the console, then hit enter.

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
    ###### At this point you'll need `master.key` file already copied into `config/`
3. Create the db and run the migrations:
    ```sh
    docker-compose run web rails db:create
    docker-compose run web rails db:migrate
    ```
4. Run the application:
    ```sh
    docker-compose up -d
    ```
    ## You'll likely see a webpacker related issue, go to the bottom of this readme to find the solution. 
    
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
# Developer useful information:

If you need to access the cronjob log do the following:
1. Run `docker ps`
2. Copy the `Container ID` for the cronjob
3. `docker exec -it {CONTAINER_ID} bash`
4. Run this line `cat /var/log/cron.log`

# IMPORTANT: FIX WEBPACK ISSUE

1. Run the following command and type `y` to override webpack existing files:
    ```sh
    docker-compose up -d
    docker-compose run web rails webpacker:install 
    ```
2. Find the following file in the code and set `check_yarn_integrity` to `false`
    ```sh
    config/webpacker.yml
    ```
3. Add Jquery (to be able to make use of an AJAX in home_controller)
    ```sh
    docker-compose up -d
    docker-compose exec web yarn add jquery
    ```
4. Locate the file `config/webpack/environment.js` and substitute its content with the following:

    ```sh
    const { environment } = require('@rails/webpacker')
    
    const webpack = require('webpack')
    environment.plugins.prepend('Provide',
        new webpack.ProvidePlugin({
            $: 'jquery/src/jquery',
            jQuery: 'jquery/src/jquery'
        })
    )
    
    module.exports = environment
    ```
5. You should be able to run the app now
    ```sh
    docker-compose up
    ```
6. Check it out with this link (locally) `http://0.0.0.0:3000/`

