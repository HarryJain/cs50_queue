import 'package:cloud_firestore/cloud_firestore.dart';

// Queue object that organizes all the relevant data related to a queue
//  entry, with members (instance variables and functions connected to
//  the object, called methods)
class Queue {
  // Object instance variables
  final String queueID;
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;

  // Constructor method that is used to create a Queue object with all its
  //  instance variables
  Queue({
    required this.queueID,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
  });

  // Method to return the instance variables of a Queue as a map
  //  (dictionary-like object)
  Map<String, dynamic> toMap() {
    return {
      'queueID': queueID,
      'name': name,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
    };
  }

  // Method to convert a DocumentSnapshot from Firestore into a Queue object
  Queue.fromDocumentSnapshot(DocumentSnapshot doc)
      : queueID = doc.id,
        name = doc.get('name'),
        description = doc.get('description'),
        startTime = doc.get('startTime').toDate(),
        endTime = doc.get('endTime').toDate(),
        location = doc.get('location');
}
