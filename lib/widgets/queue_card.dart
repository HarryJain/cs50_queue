import 'package:cs50_queue/models/queue_entry.dart';
import 'package:cs50_queue/services/database.dart';
import 'package:flutter/material.dart';

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
