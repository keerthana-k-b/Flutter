import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final firestore = FirebaseFirestore.instance;

  Future createList(String title, String uid) async {
    print("CREATE LIST CALLED");
    await firestore.collection('lists').add({
      'title': title,
      'members': [uid],
    });
    print("LIST ADDED");
  }

  Future addTask(String listId, String title, String uid) async {
    await firestore.collection('tasks').add({
      'listId': listId,
      'title': title,
      'completed': false,
    });
  }

  Stream<QuerySnapshot> getTasks(String listId) {
    return firestore
        .collection('tasks')
        .where('listId', isEqualTo: listId)
        .snapshots();
  }

Stream<QuerySnapshot> getLists(String uid) {
  return firestore
      .collection('lists')
      .where('members', arrayContains: uid)
      .snapshots();
}
  Future toggleTask(String id, bool val) async {
    await firestore.collection('tasks').doc(id).update({
      'completed': val,
    });
  }

  Future deleteTask(String id) async {
    await firestore.collection('tasks').doc(id).delete();
  }
}