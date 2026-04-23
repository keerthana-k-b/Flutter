import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

//CREATE LIST
Future createList(String title, String userId) async {
  await firestore.collection('lists').add({
    'title': title,
    'ownerId': userId,
    'members': [userId],
  });
}

//ADD TASK
Future addTask(String listId, String title, String userId) async {
  await firestore.collection('tasks').add({
    'listId': listId,
    'title': title,
    'completed': false,
    'createdBy': userId,
    'createdAt': Timestamp.now(),
  });
}

//GET TASKS
Stream<QuerySnapshot> getTasks(String listId){
  return firestore
          .collection('tasks')
          .where('listId', isEqualTo: listId)
          .snapshots();
}

//TOGGLE TASK
Future toggleTask(String taskId, bool value) async {
  await firestore
          .collection('tasks')
          .doc(taskId)
          .update({'completed': value});
}

//DELETE TASK 
Future deleteTask(String taskId) async {
  await firestore.collection('tasks').doc(taskId).delete();
}