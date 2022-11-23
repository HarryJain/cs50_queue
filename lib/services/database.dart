import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs50_queue/models/queue.dart';
import 'package:cs50_queue/models/queue_entry.dart';

// Declare a DatabaseService class to organize database methods
class DatabaseService {
  // Constructor (empty because a DatabaseService object is all methods)
  DatabaseService();

  // Store a "pointer" to the queues collection in the database
  final CollectionReference queueCollection =
      FirebaseFirestore.instance.collection('queues');

  // Query the queues collection for all the queues that are currently started
  //  and not yet ended, converting each to a Queue object and returning an
  //  updating stream of their data
  Stream<List<Queue>> queues() {
    return queueCollection
        .where('startTime', isLessThanOrEqualTo: DateTime.now())
        .where('endTime', isGreaterThan: DateTime.now())
        .orderBy('startTime')
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => Queue.fromDocumentSnapshot(doc)).toList());
  }

  // Add a new queue to the database with the given name, description,
  //  startTime, endTime, and location
  Future addQueue(String name, String description, DateTime startTime,
      DateTime endTime, String location) async {
    DocumentReference queueEntryReference = await queueCollection.add({
      'name': name,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
    });
  }

  // Query the queues collection for all the queueEntries in the given queueID,
  //  converting each to a QueueEntry object and returning an updating stream
  //  of their data
  Stream<List<QueueEntry>> queueEntries(String queueID) {
    return queueCollection
        .doc(queueID)
        .collection('queueEntries')
        .orderBy('queueTime')
        .where('dismissed', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs
            .map((doc) => QueueEntry.fromDocumentSnapshot(doc))
            .toList());
  }

  // Add a new document to the given queue with the given name, problem, and
  //  table
  Future addQueueEntry(
      String queueID, String name, String problem, String table) async {
    DocumentReference queueEntryReference =
        await queueCollection.doc(queueID).collection('queueEntries').add({
      'name': name,
      'problem': problem,
      'table': table,
      'queueTime': DateTime.now(),
      'dismissed': false,
    });
  }

  // Add a new document to the given queue with the given name, problem, and
  //  table
  Future dismiss(String queueID, QueueEntry entry) async {
    return await queueCollection
        .doc(queueID)
        .collection('queueEntries')
        .doc(entry.entryID)
        .update({
      'dismissed': true,
    });
  }
}
