import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('Users').withConverter<UserModel>(
            fromFirestore: (docSnapshot, _) =>
                UserModel.fromJson(docSnapshot.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );

  static CollectionReference<TaskModel> getTasksCollection(String userId) =>
      getUsersCollection()
          .doc(userId)
          .collection('tasks')
          .withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) =>
                TaskModel.fromJson(docSnapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );

  static Future<void> addTaskToFireStore(TaskModel task, String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
    DocumentReference<TaskModel> docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFireStore(String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
    QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
    return querySnapshot.docs
        .map(
          (docSnapshot) => docSnapshot.data(),
        )
        .toList();
  }

  static Future<void> deleteTaskFromFirestore(
      String taskId, String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
    return taskCollection.doc(taskId).delete();
  }

  static Future<void> editIsDone(TaskModel task, String userId) {
    return getTasksCollection(userId).doc(task.id).update(
      {'isDone': !task.isDone!},
    );
  }

  static Future<void> editTask(TaskModel task, String userId) {
    return getTasksCollection(userId).doc(task.id).update(task.toJson());
  }

  static Future<UserModel> register({
    required String password,
    required String name,
    required String email,
  }) async {
    final credentials =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserModel(
      id: credentials.user!.uid,
      email: email,
      name: name,
    );
    final userCollection = getUsersCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login(
      {required String email, required String password}) async {
    // await Future.delayed(
    //   Duration(seconds: 1),
    // );
    final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    credentials.user!.uid;
    final userCollection = getUsersCollection();
    final docSnapshot = await userCollection.doc(credentials.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}
