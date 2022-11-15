import 'package:cloud_firestore/cloud_firestore.dart';

class QueueEntry {
  final String entryID;
  final String name;
  final String table;
  final String problem;
  final DateTime queueTime;

  QueueEntry({
    required this.entryID,
    required this.name,
    required this.table,
    required this.problem,
    required this.queueTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'entryID': entryID,
      'name': name,
      'table': table,
      'problem': problem,
      'queueTime': queueTime,
    };
  }

  QueueEntry.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : entryID = doc.id,
        name = doc.get('name'),
        table = doc.get('table'),
        problem = doc.get('problem'),
        queueTime = doc.get('queueTime');
}
