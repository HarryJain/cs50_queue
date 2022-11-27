# Step 6: Queue Listview

## Overview
With this step, we take our queue data from the form and display it as a list, with dismissable cards for each member of the queue.

## Getting Started

For this step, the most useful resources are:

- [Official listview documentation](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [Official streambuilder documentation](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html)
- [The Net Ninja's listview video](https://youtu.be/TKM6_MTNGsI)
- [The Net Ninja's streambuilder video](https://youtu.be/PT3v28eyOqg)
- [A nice listview example](https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0) on which I based some of the design

## Objectives
By the end of this step, make sure you have
- [ ] Created the `QueueCard` widget that returns a `Dismissable` `Card` with a `ListTile` child containing all the data for a queue entry
- [ ] Wrote a `dismiss` function in `database.dart` that sets a `dismissed` flag to `true`, and also modified `addQueueEntry` to set `dismissed` to `False` by default
- [ ] Implemented the `onDismissed` property of the `QueueCard` to call your `dismiss` function on a `DatabaseService` instance
- [ ] Updated the `queueEntries` stream in `database.dart` to be based on a `String queueId` instead of a `Queue` object itself (useful in the `Steambuilder`)
- [ ] Refactored the `QueuePage` widget to have a `StreamBuilder` widget with the `queueEntries` stream from a `DatabaseService` instance
- [ ] Created a `ListView.builder` in the `builder` of the `StreamBuilder` that creates a `QueueCard` for each entry in the queue
