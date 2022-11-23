import 'package:cs50_queue/widgets/add_queue_page.dart';
import 'package:cs50_queue/widgets/queue_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Set the default page index of the BottomNavigationBar to 0 (the leftmost)
  int _selectedIndex = 0;

  // Function for updating the app state with the new page index when the
  //  BottomNavigationBar is clicked
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of pages that the BottomNavigationBar contains
  final List<Widget> _pages = [
    const QueuePage(),
    const AddQueuePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // The Scaffold widget here contains a shared AppBar and BottomNavigationBar
    //  with a body that changes between the different pages of the app
    return Scaffold(
      // Title bar with text child
      appBar: AppBar(
        title: const Text('CS50 Queue App'),
        // Actions are the buttons to the right of the AppBar, here a settings
        //  IconButton to see the profile page
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            // When the settings icon is pressed, open the ProfileScreen page
            onPressed: () {
              // The route Navigator "pushes" a new page on top of the old one,
              //  creating a stack of pages (here the Profile page on top of
              //  the main navbar/tabs)
              Navigator.push(
                context,
                // Create a MaterialPageRoute, meaning a new route of pages to
                //  navigate, here containing the ProfileScreen
                MaterialPageRoute<ProfileScreen>(
                  // Build the built-in ProfileScreen from firebase_ui, with
                  //  a custom AppBar and a sign-out action that will pop off
                  //  the ProfileScreen and update the User status to logged out
                  //  (hence returning to the sign-in screen)
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      // The body parameter contains the main content of the Scaffold, here a
      //  padding widget that provides some margin around the whole body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // The body is dynamically set to whatever page is at the selected index
        //  of the BottomNavigationBar
        child: _pages[_selectedIndex],
      ),
      // BottomNavigationBar is a persistent row of buttons for changing which
      //  page of the app you are on
      bottomNavigationBar: BottomNavigationBar(
        // Callback function when a page button is tapped
        onTap: _onPageChanged,
        // Set the current index to be highlighted and displayed
        currentIndex: _selectedIndex,
        // Display BottomNavigationBarItems with an icon and title for each page
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Queues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue),
            label: 'Create Queue',
          ),
        ],
      ),
    );
  }
}
