import 'package:cs50_queue/services/database.dart';
import 'package:flutter/material.dart';

class JoinQueueForm extends StatefulWidget {
  const JoinQueueForm({Key? key}) : super(key: key);

  @override
  State<JoinQueueForm> createState() => _JoinQueueFormState();
}

class _JoinQueueFormState extends State<JoinQueueForm> {
  // Global key to save the specific state of this form
  final _formKey = GlobalKey<FormState>();

  // Hardcode in the single queue available
  final String queueID = '4lviuIOEGylkY3UIy7yt';

  // Temporary String variables to store the form input (? allows them to
  //  be set to null by default)
  String? name;
  String? problem;
  String? table;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      // Create a form with our given key
      child: Form(
        key: _formKey,
        child: Column(
          // Vertically align from the start
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for name
            TextFormField(
              // The validator receives the text that the user has entered
              //  and checks if it is not empty
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'You must enter your name';
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
            // Input field for problem
            TextFormField(
              // Label the input with hint text
              decoration: const InputDecoration(
                labelText: 'Problem/Question',
              ),
              // Whenever the user changes their input, update the temporary
              //  problem variable
              onChanged: (String? input) {
                problem = input;
              },
            ),
            // Input field for table
            TextFormField(
              // Label the input with hint text
              decoration: const InputDecoration(
                labelText: 'Table/Location',
              ),
              // Whenever the user changes their input, update the temporary
              //  table variable
              onChanged: (String? input) {
                table = input;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false
                  //  otherwise
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar alert, close
                    //  the form, and add a queue entry to the database
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Thanks for joining the queue! We will get to you soon...',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                    // Add a queue entry with the given inputs (with the ??
                    //  replacing the temporary variables with empty strings
                    //  if they are null)
                    await DatabaseService().addQueueEntry(
                        queueID, name ?? '', problem ?? '', table ?? '');
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
