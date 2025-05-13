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
## Explanation of architecture and state management approach
 Features
- Firebase Authentication (Login & Signup)

- View upcoming events (fetched via Firestore)

- RSVP/Un-RSVP to events

- Persistent session with secure storage

- Clean Architecture with Provider state management

- Error handling & loading indicators

### Architecture and State Management
#### 1. Project Structure
 - models/
Contains data models used in the app.
Example: event_model.dart defines the structure of an event object.

- providers/
Contains state management logic using the Provider package.

event_provider.dart: 
Handles all event-related operations (add, delete, view, RSVP).

auth_provider.dart: 
Manages authentication logic (sign in, sign up, sign out).

- components/
Reusable UI components.
Example: add_event_dialog.dart is a dialog widget for adding new events.

- pages/
Main screens of the app.

auth_screen.dart: UI for user authentication.

event_list_screen.dart: Displays the list of events and interacts with event functions.

#### 2. State Management Approach
- Provider Package:
The app uses the Provider package for state management, allowing widgets to listen and react to changes in authentication and event data.

- EventProvider:
Centralizes all event logic (add, delete, view, RSVP).
Exposes methods that are called from the UI (pages/components).

- AuthProvider:
Manages user authentication state and exposes methods for sign in, sign up, and sign out.

##### How State Flows:

Providers are initialized at the root of the widget tree.

Pages and components access providers using Provider.of or Consumer.

When a function is called (e.g., add event), the provider updates state and notifies listeners, causing the UI to rebuild as needed.

#### 3. Example Usage
```dart
// Accessing event provider in event_list_screen.dart
final eventProvider = Provider.of<EventProvider>(context);
eventProvider.addEvent( title: result['title'],
                    description: result['description'],
                    date: result['date'],
                    userId: userId!,);
```
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

