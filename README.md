# Event Management App
## Testing the app
Click on Create new account for a new user
Register: Enter an email and a password containing more than 6 characters on the apt text-inputs. 
It will lead you to a screen of event list

Login:
Enter your email and password of registration-click on login- you will be lead to Event List Screen

Logout:
There is an icon to press on the event list screen, it will log you out and lead you to login screen

## RSVP
- plus icon- enter details to create new event
- it shows up as a card on the list of events
- to rsvp, there is a checkbox which when clicked updates the number of rsvp's 
- to delete an event, there is a delete icon 
## Session persistence
- Flutter secure storage is storing the Firebase user token for each user
- I have made use of an AuthWrapper that checks if user is already logged in in previous session and accordingly shows a login screen or event list.
- This is done through Firebase auth
- To test, dont logout and close app
- open app again and you will be on event list screen

