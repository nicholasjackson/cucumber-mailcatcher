# cucumber-mailcatcher
This gem provides default steps for cucumber to interact with the mailcatcher test SMTP server [http://mailcatcher.me/](http://mailcatcher.me/)

You can write steps such as:
`Then I should receive an email from "jackson.nic@gmail.com"`

or

```
Then I should receive an email with the following details
  | To                    | From          | Subject       |
  | jackson.nic@gmail.com | test@test.com | My test email | 
```

or 

`Then I should receive an email with a body containing "Some body content"`

