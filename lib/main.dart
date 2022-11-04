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
        onPressed: () {},
        // An accessibility description on long press
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
