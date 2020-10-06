# README

Simple iphone friendly group  space coordination

Depoloyed at:

https://www.bernumdze.org

https://bernumdze.herokuapp.com/

* Test using:

```
rspec
```



* Deployment instructions
```
  $ heroku login
  $ heroku git:remote -a bernumdze      # first time config only
  $ git push heroku master
  $ heroku run rake db:migrate
  $ heroku ps:scale web=1               # to have only 1 dyno (inexpensive)
  $ heroku run rails console
  > User.create(email: "xxx", username: "xxx", real_name: "xxx", password: "xxx", password_confirmation: "xxx")
  > Space.create(space_name: "Zentrum")
  > exit
* ...
