import 'package:cs50_queue/models/queue_entry.dart';
import 'package:cs50_queue/services/database.dart';
import 'package:cs50_queue/widgets/join_queue_form.dart';
import 'package:cs50_queue/widgets/queue_card.dart';
import 'package:flutter/material.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({Key? key}) : super(key: key);

  final String queueID = '4lviuIOEGylkY3UIy7yt';

  @override
  Widget build(BuildContext context) {
    // The Scaffold widget contains useful structures like a title bar,
    //  floating button, etc.
    return Scaffold(
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
            builder: (context) => const JoinQueueForm(),
          );
        },
        // An accessibility description on long press
        tooltip: 'Join Queue',
        child: const Icon(Icons.add),
      ),
    );
  }
}