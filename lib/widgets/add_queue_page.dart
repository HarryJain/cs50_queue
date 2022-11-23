import 'package:cs50_queue/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddQueuePage extends StatefulWidget {
  const AddQueuePage({Key? key}) : super(key: key);

  @override
  State<AddQueuePage> createState() => _AddQueuePageState();
}

class _AddQueuePageState extends State<AddQueuePage> {
  // Global key to save the specific state of this form
  final _formKey = GlobalKey<FormState>();

  // Temporary variables to store the form input (? allows them to
  //  be set to null by default)
  String? name;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  String? location;

  // TextEditingControllers allow for manual setting of the text fields for
  //  start time and end time
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // Horizontally align from the center
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Row for Name
          Row(
            children: [
              // Icon for name
              const IconButton(
                icon: Icon(Icons.drive_file_rename_outline),
                onPressed: null,
              ),
              // Expanded widget forces TextFormField to take up all available
              //  horizontal space
              Expanded(
                // Input field for name
                child: TextFormField(
                  // The validator receives the text that the user has entered
                  //  and checks if it is not empty
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'You must enter a queue name';
                    }
                    return null;
                  },
                  // Label the input with hint text
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  // Whenever the user changes their input, update the temporary
                  //  name variable
                  onChanged: (String? input) {
                    name = input;
                  },
                ),
              ),
            ],
          ),
          // Row for Description
          Row(
            children: [
              // Icon for description
              const IconButton(
                icon: Icon(Icons.description_outlined),
                onPressed: null,
              ),
              // Expanded widget forces TextFormField to take up all available
              //  horizontal space
              Expanded(
                // Input field for description
                child: TextFormField(
                  // Label the input with hint text
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  // Whenever the user changes their input, update the temporary
                  //  description variable
                  onChanged: (String? input) {
                    description = input;
                  },
                ),
              ),
            ],
          ),
          // Row for Start Time
          Row(
            children: [
              // Clickable IconButton for picking a DateTime
              IconButton(
                icon: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  // When the IconButton is pressed, show a pop-up to choose a
                  //  DateTime
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    // Allow for DateTime values from now until 31 days from now
                    minTime: DateTime.now(),
                    maxTime: DateTime.now().add(const Duration(days: 31)),
                    // When the choice is confirmed, update the temporary
                    //  startTime variable and startController text
                    onConfirm: (date) {
                      startTime = date;
                      startController.text = startTime.toString();
                    },
                    currentTime: DateTime.now(),
                  );
                },
              ),
              // Expanded widget forces TextFormField to take up all available
              //  horizontal space
              Expanded(
                child: TextFormField(
                  // Set a controller so that we can manually modify the value
                  //  to match the DateTimePicker
                  controller: startController,
                  enabled: false,
                  // Label the input with hint text
                  decoration: const InputDecoration(
                    labelText: 'Start Time',
                  ),
                  // The validator receives the DateTime that the user has
                  //  entered and checks if it is not empty
                  validator: (value) {
                    if (startTime == null) {
                      return 'You must enter a start time';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          // Row for End Time
          Row(
            children: [
              // Clickable IconButton for picking a DateTime
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  // When the IconButton is pressed, show a pop-up to choose a
                  //  DateTime
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    // Allow for DateTime values from startTime until 32 days
                    //  from now
                    minTime: startTime,
                    maxTime: DateTime.now().add(const Duration(days: 32)),
                    // When the choice is confirmed, update the temporary
                    //  endTime variable and endController text
                    onConfirm: (date) {
                      endTime = date;
                      endController.text = endTime.toString();
                    },
                    currentTime: startTime ?? DateTime.now(),
                  );
                },
              ),
              // Expanded widget forces TextFormField to take up all available
              //  horizontal space
              Expanded(
                child: TextFormField(
                  // Set a controller so that we can manually modify the value
                  //  to match the DateTimePicker
                  controller: endController,
                  enabled: false,
                  // Label the input with hint text
                  decoration: const InputDecoration(
                    labelText: 'End Time',
                  ),
                  // The validator receives the DateTime that the user has
                  //  entered and checks if it is not empty
                  validator: (value) {
                    if (endTime == null) {
                      return 'You must enter a end time';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          // Row for Location
          Row(
            children: [
              // Icon for location
              const IconButton(
                icon: Icon(Icons.place_outlined),
                onPressed: null,
              ),
              // Expanded widget forces TextFormField to take up all available
              //  horizontal space
              Expanded(
                // Input field for location
                child: TextFormField(
                  // Label the input with hint text
                  decoration: const InputDecoration(
                    labelText: 'Location',
                  ),
                  // The validator receives the text that the user has entered
                  //  and checks if it is not empty
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'You must enter a queue location';
                    }
                    return null;
                  },
                  // Whenever the user changes their input, update the temporary
                  //  location variable
                  onChanged: (String? input) {
                    location = input;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false
                //  otherwise
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar alert, close
                  //  the form, and add a queue to the database
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Thanks for creating a queue! It should appear on the Queues page now...',
                      ),
                    ),
                  );
                  // Add a queue with the given inputs (with the ??
                  //  replacing the temporary variables with empty strings
                  //  or default dates if they are null)
                  await DatabaseService().addQueue(
                    name ?? '',
                    description ?? '',
                    startTime ?? DateTime.now(),
                    endTime ?? DateTime.now(),
                    location ?? '',
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
