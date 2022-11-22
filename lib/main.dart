import 'package:cs50_queue/models/queue_entry.dart';
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

  final String queueID = '4lviuIOEGylkY3UIy7yt';

  @override
  Widget build(BuildContext context) {
    // The Scaffold widget contains useful structures like a title bar,
    //  floating button, etc.
    return Scaffold(
      // Title bar with text child
      appBar: AppBar(
        title: const Text('CS50 Queue'),
      ),
      // The body parameter contains the main content of the Scaffold, here a
      //  padding widget that provides some margin around the whole body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // A StreamBuilder takes in a stream of data and dynamically updates
        //  the widgets in its builder whenever the data changes
        child: StreamBuilder(
          // Here the data stream is all the queue entries from this queue
          stream: DatabaseService().queueEntries(queueID),
          // The builder takes in the current snapshot of data and returns a
          //  list of queue entries if there are any
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // If there are queue entries, create a list of them
              return ListView.builder(
                itemCount: snapshot.data?.length,
                // Loop over the items in snapshot.data and create a QueueCard
                //  for each
                itemBuilder: (context, index) {
                  // Here, we know that snapshot.data is not null, but we need
                  //  the ? to confirm this to the compiler
                  QueueEntry? entry = snapshot.data?[index];
                  return QueueCard(
                    entry: entry,
                    queueID: queueID,
                    index: index,
                  );
                },
              );
            } else {
              // Return an empty container if there are no queue entries
              return Container();
            }
          },
        ),
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
            // When the button is pressed, open up a form to add yourself to
            //  the queue
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

class QueueCard extends StatelessWidget {
  const QueueCard({
    Key? key,
    required this.entry,
    required this.queueID,
    required this.index,
  }) : super(key: key);

  final QueueEntry? entry;
  final String queueID;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Each Dismissible must contain a Key to uniquely
      //  identify widgets.
      key: Key(entry?.entryID ?? ''),
      // Provide a function that tells the app
      //  what to do after an item has been swiped away
      onDismissed: (direction) {
        // Flag the queue entry as dismissed/helped
        DatabaseService().dismiss(queueID, entry!);

        // Then show a snackbar with the name/index
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${entry?.name ?? index} dismissed')));
      },
      // Show a red background as the item is swiped away.
      background: Container(color: Colors.red),
      // The actual element to dismiss is a Card that "floats" above the page
      child: Card(
        // The Card contains a ListTile that allows for easy formatting of
        //  important text
        child: ListTile(
          // To the left of the ListTile, put the index of the queue entry
          //  followed by a divider
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$index'),
              const SizedBox(width: 8.0),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0.0,
                ),
                child: VerticalDivider(),
              ),
            ],
          ),
          // Set the title, subtitle, and trailing text to the relevant parts
          //  of the queue entry
          title: Text(entry?.name ?? ''),
          subtitle: Text(entry?.problem ?? ''),
          trailing: Text('Location: ${entry?.table ?? ''}'),
        ),
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
