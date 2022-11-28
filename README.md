# Step 12: Profile Page

## Overview

This step is really just a continuation of Step 11, adding a profile page for the currently logged-in user (which also includes a logout button). Additionally, it demonstrates how the navigator stack works for detail pages.

## Resources

Like in Step 11, there are two main resources

- [Lab: Add a user authentication flow to a Flutter app using FirebaseUI](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps?hl=en#0)
- [The Firebase UI Auth package documentation](https://pub.dev/packages/firebase_ui_auth)

If you follow the steps of the lab, you will end up with very similar code to Steps 11 and 12 of the workshop.

## Objectives
By the end of this step, make sure you have
- [ ] Added an `IconButton` inside the app bar `actions` in `home.dart`
- [ ] Set the `onPressed` property of that `IconButton` to `push` a `MaterialPageRoute` that builds a `ProfileScreen` and has a `SignedOutAction` that pops this profile page off the `Navigator` stack
