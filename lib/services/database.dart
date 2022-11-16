import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs50_queue/models/queue.dart';
import 'package:cs50_queue/models/queue_entry.dart';

// Declare a DatabaseService class to organize database functions
class DatabaseService {
  // Constructor (empty because a DatabaseService object is all functions)
  DatabaseService();

  // Store a "pointer" to the queues collection in the database
  final CollectionReference queueCollection =
      FirebaseFirestore.instance.collection('queues');

  // Query the queues collection for all the queueEntries in the given queue,
  //  converting each to a QueueEntry object and returning an updating stream
  //  of their data
  Stream<List<QueueEntry>> queueEntries(Queue queue) {
    return queueCollection
        .doc(queue.queueID)
        .collection('queueEntries')
        .orderBy('queueTime')
        .snapshots()
        .map((event) => event.docs
            .map((doc) => QueueEntry.fromDocumentSnapshot(doc))
            .toList());
  }

  // Add a new document to the given queue with data from the QueueEntry
  Future addQueueEntry(Queue queue, QueueEntry queueEntry) async {
    DocumentReference queueEntryReference = await queueCollection
        .doc(queue.queueID)
        .collection('queueEntries')
        .add(queueEntry.toMap());
  }
}
