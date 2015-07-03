# cucumber-mailcatcher
[![Build Status](https://travis-ci.org/nicholasjackson/cucumber-mailcatcher.svg?branch=master)](https://travis-ci.org/nicholasjackson/cucumber-mailcatcher)
[![Coverage Status](https://coveralls.io/repos/nicholasjackson/cucumber-mailcatcher/badge.svg?branch=master)](https://coveralls.io/r/nicholasjackson/cucumber-mailcatcher?branch=master)

This gem provides default steps for cucumber to interact with the mailcatcher test SMTP server [http://mailcatcher.me/](http://mailcatcher.me/)

## Steps:  

### Query messages in mail catcher
#### Query by single parameters 
`Then I should receive an email from "jackson.nic@gmail.com"`  
`Then I should receive an email sent to "jackson.nic@gmail.com"`  
`Then I should receive an email with subject "A subject"`  
`Then I should receive an email with a body containing "Some body content"`  

#### Query by table
```
Then I should receive an email with the following details
  | To                    | From          | Subject       |
  | jackson.nic@gmail.com | test@test.com | My test email | 
```

### Delete all messages
`Given I delete all mail messages`

