# Event Management App
## Setup Instructions
### Prerequisites

- Flutter SDK
- Firebase Project (Android Enabled)
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

### Testing the App

#### Registration

- **Create New Account:**  
  Click on **Create New Account** to register as a new user.  
  Enter a valid email address and a password (minimum 6 characters) in the provided fields.  
  Upon successful registration, you will be navigated to the Event List screen.

#### Login

- **Sign In:**  
  Enter your registered email and password, then click **Login**.  
  Successful authentication will take you directly to the Event List screen.

#### Logout

- **Sign Out:**  
  On the Event List screen, tap the logout icon in the app bar.  
  This will sign you out and redirect you back to the Login screen.

### Event Management & RSVP

- **Create Event:**  
  Tap the **plus (+) icon** to open the event creation dialog.  
  Enter the event details and submit; the new event will appear as a card in the event list.

- **RSVP to Event:**  
  Each event card includes an RSVP checkbox.  
  Tapping the checkbox updates the RSVP count for that event in real time.

- **Delete Event:**  
  Each event card has a delete icon.  
  Tap it to remove the event from the list.

### Session Persistence

- **Automatic Login:**  
  User sessions are persisted using Flutter Secure Storage, which securely stores the Firebase user token.
- **AuthWrapper:**  
  On app launch, the `AuthWrapper` checks if a user session exists:
    - If the user is already authenticated, the app navigates directly to the Event List screen.
    - If not, the Login screen is displayed.
- **Powered by Firebase Auth:**  
  All authentication and session management is handled via Firebase Authentication.


To test session persistence, log in and close the app without logging out. Reopen the app, and you will be taken directly to the Event List screen.



