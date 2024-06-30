import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //*get
  final CollectionReference notes =
      FirebaseFirestore.instance.collection("Notes");

  //*CREATE
  Future<DocumentReference<Object?>> addNotes(String note) async {
    final User? user = _auth.currentUser;
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
      'userID': user!.uid,
    });
  }

  //*READ
  Stream<QuerySnapshot<Object?>> getNotes() {
    final User? user = _auth.currentUser;
    final notesStream = notes
        .where('userID', isEqualTo: user!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
    return notesStream;
  }

  //*UPDATE
  Future<void> updateNotes(String docID, String newNote) async {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  //*DELETE
  Future<void> deleteNote(String docID) async {
    return notes.doc(docID).delete();
  }
}
