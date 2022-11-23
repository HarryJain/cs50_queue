import 'package:cs50_queue/widgets/queue_page.dart';
import 'package:flutter/material.dart';

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
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    // The Scaffold widget here contains a shared AppBar and BottomNavigationBar
    //  with a body that changes between the different pages of the app
    return Scaffold(
      // Title bar with text child
      appBar: AppBar(
        title: const Text('CS50 Queue App'),
      ),
      // The body is dynamically set to whatever page is at the selected index
      //  of the BottomNavigationBar
      body: _pages[_selectedIndex],
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
