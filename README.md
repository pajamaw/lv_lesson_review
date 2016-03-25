# lv_lesson_review


This is a rails app that uses omniauth via github, where you can review each learn verified lesson from 1-5 as well as comment on specifics of the lesson. The user may sign up by creating an account or through their respective GitHub login. 

Users that sign in with their GH credentials will automatically be given admin rights, where as those that sign up through the site will start as a member. Using Pundit those that sign up have the following permissions:

Member:
-create comments
-create ratings
-edit their own comments and ratings
-delete their own comments and ratings
-delete their profile
-view their own profile

Vip:
-create comments
-create ratings
-edit their own comments and ratings
-delete their own comments and ratings
-delete other users comments and ratings
-delete their profile
-view their own profile 
-view others profiles

Admin:
-create comments
-create ratings
-edit their own comments and ratings
-edit others comments and ratings
-delete their own comments and ratings
-delete other users comments and ratings
-delete their profile
-delete others profiles
-view their own profile 
-view others profiles
-view all user profiles as an index

To get started with this project, run rake db:seed to intialize the scraper which will fill out the lesson and category information from my learn.co profile. (As long as their css doesn't change!)

Please let me know if you have any questions or concerns!

