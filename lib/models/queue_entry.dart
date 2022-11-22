import 'package:cloud_firestore/cloud_firestore.dart';

// QueueEntry object that organizes all the relevant data related to a
//  queue entry, with members (instance variables and functions connected to
//  the object, called methods)
class QueueEntry {
  // Object instance variables
  final String entryID;
  final String name;
  final String table;
  final String problem;
  final DateTime queueTime;

  // Constructor method that is used to create a QueueEntry object with all its
  //  instance variables
  QueueEntry({
    required this.entryID,
    required this.name,
    required this.problem,
    required this.table,
    required this.queueTime,
  });

  // Method to return the instance variables of a QueueEntry as a map
  //  (dictionary-like object)
  Map<String, dynamic> toMap() {
    return {
      'entryID': entryID,
      'name': name,
      'problem': problem,
      'table': table,
      'queueTime': queueTime,
    };
  }

  // Method to convert a DocumentSnapshot from Firestore into a QueueEntry
  //  object
  QueueEntry.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : entryID = doc.id,
        name = doc.get('name'),
        problem = doc.get('problem'),
        table = doc.get('table'),
        queueTime = doc.get('queueTime').toDate();
}
