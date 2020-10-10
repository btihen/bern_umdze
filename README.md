# README

Simple iphone friendly group space schedule coordination

## Depoloyed at:

https://www.bernumdze.org

https://bernumdze.herokuapp.com/

* Test using:

```
rspec
```

## adding JS modal to a calendar:
see: https://www.sitepoint.com/jquery-document-ready-plain-javascript/
modal code from: https://siongui.github.io/2018/02/11/bulma-modal-with-javascript/

Create JS File
```
mkdir app/javascript/calendars
touch app/javascript/calendars/event_modal.js
```
wrap the plain JS in the `DOMContentLoaded`:
```
document.addEventListener('DOMContentLoaded', function () {
  // javascript
});
```
Create a new `pack`:
```
toucn app/javascript/packs/calendar.js
```
now add the contents:
```
require("calendars/event_modal")
```

Now on the desired page add:
```
<%= javascript_pack_tag 'calendar' %>
```

otherwise you can add the raw js to the needed page with:
```
<script>
// javascript
</script>
```

## force https & *.bernumdze.org -> www.bernumdze.org (redirect)
https://stackoverflow.com/questions/34862065/force-my-heroku-app-to-use-ssl-https

## Deployment instructions
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
```
