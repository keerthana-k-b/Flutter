import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_provider/data/services/task_service.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService service;

  TaskProvider(this.service);

  Future createList(String title, String uid) async {
    await service.createList(title, uid);
  }

  Future addTask(String listId, String title, String uid) async {
    await service.addTask(listId, title, uid);
  }

  Stream<QuerySnapshot> getTasks(String listId) {
    return service.getTasks(listId);
  }
  
  Stream<QuerySnapshot> getLists(String uid) {
  return service.getLists(uid);
}

  Future toggleTask(String id, bool val) async {
    await service.toggleTask(id, val);
  }

  Future deleteTask(String id) async {
    await service.deleteTask(id);
  }
}