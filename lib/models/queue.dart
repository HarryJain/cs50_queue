import 'package:cloud_firestore/cloud_firestore.dart';

class Queue {
  final String queueID;
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;

  Queue({
    required this.queueID,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
  });

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

  Queue.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : queueID = doc.id,
        name = doc.get('name'),
        description = doc.get('description'),
        startTime = doc.get('startTime'),
        endTime = doc.get('endTime'),
        location = doc.get('location');
}
