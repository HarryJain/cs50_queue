# Step 8: Bottom Navigation Bar

## Overview

Once again, this step is a pretty straightforward implementation of a built-in Flutter widget: BottomNavigationBar. In order to do so, we create a Home widget with a BottomNavigationBar that changes which page the Home widget displays as the body of its Scaffold.

## Resources

This implementation follows the [official docs](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html) fairly closely, so that is probably the best place to look!

## Objectives
By the end of this step, make sure you have
- [ ] Created the `home.dart` file implementing the `Home` `StatefulWidget`
- [ ] Written an `_onPageChanged` function for changing the displayed page on navigation bar press
- [ ] Made a `pages` list to include a `QueuePage` and an empty `Container`
- [ ] Implemented a `BottomNavigationBar` with two `BottomNavigationBarItem`s, one for each page
- [ ] Changed the `home` property of your `MaterialApp` in `main.dart` to be a `const Home()`
