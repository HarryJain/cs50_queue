# Step 5: Join Queue Form

## Overview
This step involves creating a form for adding yourself to the queue when you press the add floating action button.

## Resources

Most of this step is based on the official Flutter documentation, primarily

- [The Form widget](https://docs.flutter.dev/cookbook/forms/validation)
- [The showModalBottomSheet function](https://api.flutter.dev/flutter/material/showModalBottomSheet.html) to display the form as a floating sheet

## Objectives
By the end of this step, make sure you have
- [ ] Created a `QueueEntryForm` widget with three `TextFormField`s for getting the person's `name`, `problem`, and `table`, which we store in temporary `String?` variables
- [ ] Add a submit `ElevatedButton` to `QueueEntryForm` that validates the form, calls `showSnackBar` to display an alert, pops the form off the `Navigator` stack, and calls the `addQueueEntry` on a `DatabaseService` instance
- [ ] Set the `onPressed` property of the `floatingActionButton` to return a `showModalBottomSheet` function, with a builder that returns our `QueueEntryForm`
