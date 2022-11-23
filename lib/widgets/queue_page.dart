import 'package:cs50_queue/models/queue_entry.dart';
import 'package:cs50_queue/services/database.dart';
import 'package:cs50_queue/widgets/join_queue_form.dart';
import 'package:cs50_queue/widgets/queue_card.dart';
import 'package:flutter/material.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This StreamBuilder takes in a stream of updating data (here the queues
    //  in the database) and builds its child widgets accordingly
    return StreamBuilder(
      stream: DatabaseService().queues(),
      builder: (context, snapshot) {
        // The builder takes in the current snapshot of data and returns a
        //  Scaffold with a TabBarView of queues if there are any
        if (snapshot.hasData) {
          // DefaultTabController controls the changing tabs for each queue
          return DefaultTabController(
            length: snapshot.data?.length ?? 0,
            // The Scaffold widget contains useful structures like a title bar,
            //  floating button, etc.
            child: Scaffold(
              // This AppBar sits below the main one with the page title and
              //  has a Tab for each queue
              appBar: AppBar(
                title: TabBar(
                  isScrollable: true,
                  tabs: snapshot.data!
                      .map((queue) => Tab(text: queue.name))
                      .toList(),
                ),
              ),
              // The body parameter contains the main content of the Scaffold, here
              // a TabBarView of queues
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TabBarView(
                  children: snapshot.data!
                      .map((queue) => QueueTab(queueID: queue.queueID))
                      .toList(),
                ),
              ),
            ),
          );
          // Return an empty container if there are no queue entries
        } else {
          return Container();
        }
      },
    );
  }
}

class QueueTab extends StatelessWidget {
  const QueueTab({
    Key? key,
    required this.queueID,
  }) : super(key: key);

  final String queueID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body parameter contains the main content of the Scaffold, here a
      //  StreamBuilder that dynamically creates a list of queue entries
      body: StreamBuilder(
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
                // Build a QueueCard for the given queue entry
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
      // Floating button with a plus sign for adding to the queue
      floatingActionButton: FloatingActionButton(
        // When the button is pressed, call this async function to show the
        //  bottom sheet, which means that you can wait for something that
        //  takes some time (i.e. user input) before running the subsequent code
        onPressed: () async {
          return await showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            // When the button is pressed, open up a form to add
            //  yourself to the queue of the current tab
            builder: (context) => JoinQueueForm(
              queueID: queueID,
            ),
          );
        },
        // An accessibility description on long press
        tooltip: 'Join Queue',
        child: const Icon(Icons.add),
      ),
    );
  }
}
