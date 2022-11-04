import 'package:cloud_firestore/cloud_firestore.dart';

class QueueEntry {
  final String name;
  final DateTime joined;

  const QueueEntry({
    required this.name,
    required this.joined,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  QueueEntry.fromDocumentSnapshot(DocumentSnapshot doc)
      : name = doc.get('name'),
        joined = doc.get('joined');
}
