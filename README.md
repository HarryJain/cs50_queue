# Step 9: Add Queue

## Overview
This step implements the functionality for adding a new queue, e.g. a queue for Flutter projects. It does so using a very similar form to the one for joining the queue, so many of the same principles apply.

## Resources

Beyond the resources for the Join Queue Form in Step 5, there are a few new widgets introduced here:

- [IconButton](https://api.flutter.dev/flutter/material/IconButton-class.html)
- [Expanded](https://api.flutter.dev/flutter/widgets/Expanded-class.html)
- [DatePicker](https://pub.dev/packages/flutter_datetime_picker) from the flutter_datetime_picker package (see the [installing page](https://pub.dev/packages/flutter_datetime_picker/install) for more instructions)

## Objectives
By the end of this step, make sure you have
- [ ] Written a `queues` function returning a `Stream` of all the queues in the database
- [ ] Written a `addQueue` function for adding a new queue to the queue collection in your database for the given input data
- [ ] Created the `add_queue_page.dart` file implementing the `AddQueuePage` `StatefulWidget`
- [ ] Added three `TextFormField`s for getting the queue's `name`, `description`, and `location`, which we store in temporary `String?` variables, displayed in a row with a disabled `IconButton` to match styling
- [ ] Addeed two `IconButton`s that call the `DatePicker.showDateTimePicker` function for getting the queue's `startTime` and `endTime`, which are stored in temporary `DateTime?` variables, along with disabled `TextFormField`s to display the currently selected date automatically
- [ ] Add a submit `ElevatedButton` to `AddQueuePage` that validates the form, calls `showSnackBar` to display an alert, and calls the `addQueue` on a `DatabaseService` instance
