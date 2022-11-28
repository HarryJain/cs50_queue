# Step 11: Authentication

## Overview

This step is a very useful one for making any kind of personalized application and could really be done any time after the initial Firebase setup in Step 1. It utilizes the built-in widgets from Firebase UI Auth.

## Resources

For this portion of the workshop, there are two main resources

- [Lab: Add a user authentication flow to a Flutter app using FirebaseUI](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps?hl=en#0)
- [The Firebase UI Auth package documentation](https://pub.dev/packages/firebase_ui_auth)

If you follow the steps of the lab, you will end up with very similar code to Steps 11 and 12 of the workshop.

## Objectives
By the end of this step, make sure you have
- [ ] Created the `AuthGate` `StatelessWidget` in `auth_gate.dart` that returns a `StreamBuilder` with a stream of `authStateChanges`, whose `builder` returns a `SignInScreen` if there is no data (no logged in user) and the `Home` widget otherwise
- [ ] Modified the `home` of the `MaterialApp` in `main.dart` to return an `AuthGate` widget
