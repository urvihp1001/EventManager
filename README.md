# Event Management App
## Setup Instructions
### Prerequisites

- Flutter SDK
- Firebase Project (Web, Android, iOS enabled)
- Firebase Authentication and Firestore enabled

### 1. Clone the Repository
```bash
git clone https://github.com/urvihp1001/EventManager.git
cd EventManager
```
### 2. Install dependencies
 flutter pub get
### 3. Create a .env file in root folder of project
Add API Key to it (Haven't enclosed it in Github)

### 4. To test on phone
flutter build apk --release
download apk file on phone 

## Testing the app
Click on Create new account for a new user
Register: Enter an email and a password containing more than 6 characters on the apt text-inputs. 
It will lead you to a screen of event list

Login:
Enter your email and password of registration-click on login- you will be lead to Event List Screen

Logout:
There is an icon to press on the event list screen, it will log you out and lead you to login screen

### RSVP
- plus icon- enter details to create new event
- it shows up as a card on the list of events
- to rsvp, there is a checkbox which when clicked updates the number of rsvp's 
- to delete an event, there is a delete icon 
### Session persistence
- Flutter secure storage is storing the Firebase user token for each user
- I have made use of an AuthWrapper that checks if user is already logged in in previous session and accordingly shows a login screen or event list.
- This is done through Firebase auth
- To test, dont logout and close app
- open app again and you will be on event list screen

