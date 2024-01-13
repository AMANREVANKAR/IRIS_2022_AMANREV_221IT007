# Messinfo

This project is basically a app which is designed to revolutionize mess system  - the ultimate Mess Management App,which is based on a flutter framework, which will help students and mess owners for navigating through mess related activities.

## Technologies used
- bloc state management,TDD architecture,Firebase database,Hive,google cloud messging,Dart language,flutter framework,

## Implemented Features

### User related features:

- User gets to register for the mess initially using his emailid and password, the choice of his mess and current mess balance is also taken as a input,

- Users info such as name,emailid,roll no,currmess and mess balance per day of selected mess (Which is fetched from the database ) are stored in local storage hive 

- Display of all essential information of user is shown such as name,emailid,roll no,currmess and mess balance per day of selected mess are shown in home page 

- User can login and logout 

- User can request for a mess change, all available mess will show with different  info such as type of mess veg/non veg, menu of the mess, and no of seats available,then user can request for mess of his choice and can also cancel request if not wanted or wrongly selected,if applied, user will get the status whether he is accepted or rejected

- User can apply for leaves with the inputs fromdate and todate  where the messbalance will not be deducted during this period else will be deducted, user can check list of dates from what date to what date he took the leaves

- If any user gets deallocated by admin due to some reason only then he can register for the mess else not

- User can add money to the existing mess balance if he has insufficient balance

- User can also give suggestion based on his food experience this suggestion will be taken from the curries he is in,and this will be completely anonymous to the admin,

### Admin related features:

- Admin can login only using given emailid and password 

- Admin can create messes with name ,menu and no of seats available, also allows to request the students for the mess change and can also cancel the request

- Admin gets the notification when user requests for the mess change

- Admin can accept and reject the user

- Admin can see all the suggestion given by the users and try improving his quality of the food,

- Admin also gets the feature to deallocate the user from the mess

### Operating systems:
- MacOs

### Refrences

- Stack overflow

- Firebase and flutter docs


