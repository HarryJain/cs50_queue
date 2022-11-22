import 'package:cs50_queue/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS50 Queue',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // This is the main page of the app
      home: const QueuePage(),
    );
  }
}

class QueuePage extends StatelessWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The Scaffold widget contains useful structures like a title bar,
    //  floating button, etc.
    return Scaffold(
      // Title bar with text child
      appBar: AppBar(
        title: const Text('CS50 Queue'),
      ),
      // Floating button with a plus sign for adding to the queue
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          return await showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            builder: (context) => const QueueEntryForm(),
          );
        },
        // An accessibility description on long press
        tooltip: 'Join Queue',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class QueueEntryForm extends StatefulWidget {
  const QueueEntryForm({Key? key}) : super(key: key);

  @override
  State<QueueEntryForm> createState() => _QueueEntryFormState();
}

class _QueueEntryFormState extends State<QueueEntryForm> {
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
                              'Thanks for joining the queue! We will get to you soon...')),
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
