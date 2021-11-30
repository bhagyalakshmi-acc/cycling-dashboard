# Cycling dashboard

This R program takes the cycling activites from Strava app using API and tracks my cycling habits.\
The program showcases current month dashboard and past 6 months dashboard.

Before writing the main code:

1.Set up Strava account and log your activities\
2.Create an API application with Strava here. (Note: For 'Website' put in any domain, and for 'Authorization Callback Domain' put 'localhost')\
3.Get authorization code (i.e. grant permission for python file to access your Strava data)\
a. Put your 'Client ID' in the following link (your_client_id), to then be put into your browser bar, press ENTER\
https://www.strava.com/oauth/authorize?client_id=your_client_id&redirect_uri=http://localhost&response_type=code&scope=activity:read_all \
b. Authorize the API to connect to Strava \
c. Get authorization code (your_authorization_code) from returned url in browser bar: \
http://localhost/?state=&code=your_authorization_code&scope=read,activity:read_all \
4.Get access and refresh tokens by using a POST request. \
a. Create a postman account \
b. Create a POST request with your 'Client ID', 'Client Secret', and 'Authorization Code' using the following URL: \
https://www.strava.com/oauth/token?client_id=your_client_id&client_secret=your_client_secret&code=your_authorization_code&grant_type=authorization_code  \
Obtain 'Refresh Token' and 'Access Token' to be used (along with 'Client ID') in python file to pull your data 
