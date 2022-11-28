# Step 10: Queue Tabs

Now that our app has capability for having multiple queues, this step implements a tabbed interface for navigating between them on the homepage.

## Resources

This implementation again follows the [official docs for a DefaultTabController](https://api.flutter.dev/flutter/material/DefaultTabController-class.html) fairly closely, so that is probably the best place to look!

## Objectives
By the end of this step, make sure you have
- [ ] Extract the old `QueuePage` code into a new `QueueTab` `StatelessWidget` with a required `queueID` string variable
- [ ] Modified the `QueuePage` widget to be a `StreamBuilder` connected to the `queues` stream from the database which returns a `DefaultTabController` when it has data
- [ ] Nest a `Scaffold` inside the `DefaultTabController` with a `TabBar` in the `appBar` and `TabBarView` in the `body` whose children are a list of `QueuePage`s mapped from the `queues` stream
