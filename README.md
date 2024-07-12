# connect_friends

## Description
ConnectFriends is a social networking app that allows users to register, create profiles, view a global user list, send friend invitations, and manage their friends list. The app uses Firebase for authentication and Firestore for data storage

## Features
- User Registration and Profile Creation
- Global User List and Search
- Friend Invitation and Acceptance
- Email Verification

## Prerequisites
    -Flutter (latest version)
    -Firebase Account


## Setup
1. **Clone the repo**    
    ```sh
    git clone git@github.com:ma5hudu/ConnectFriends.git
    ```

2. **install dependecies**
    ```sh
    flutter pub get
    ```

3. **Configure Firebase:**
   - Go to the Firebase Console.
   - Create a new project or use an existing project.
   - Enable firebase Authentication and firestore database
   - follow the instructions on the link to [add firebase into your project ](https://firebase.google.com/docs/flutter/setup?platform=ios) 


4. **Run the app:**
    ```sh
    flutter run
    ``` 
it will show all the connnected devices and you will choose one you want
 **OR**
 inside your project go to lib/main and then on top of void main() you will see **run|profile|debug** and click run if you are using vs code


## Usage
## User registration and profile creation
-navigate to registration screen
-input name, surname, email and upload picture and then submit the form to create an account
-check email for verification link and click it to complete the registration

## Global user list and search
-navigate to global users list screen
-view the list of all registered users
-use search bar to find specific users using the person (first name)

## Friend invitation
-navigate to the user profile by clicking the name of the person on the list
-send a friend invitation to the selected user and then the user will recieve a notification
-









A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
