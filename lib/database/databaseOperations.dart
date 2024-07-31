import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/AppRoutes.dart';

class DatabaseOperationFirebase {
  final db = FirebaseFirestore.instance;

  Future<void> createUserWithEmailPass(
      context, String email, String password) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
          Text('Conta Criada com Sucesso!')));
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        } on FirebaseAuthException catch (e) {
      print('O código é: ');
      print(e.code);
      //     if (e.code == 'weak-password') {//Codigo para senha fraca
      //       print('The password provided is too weak.');
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Já existe uma conta com este email')));
      } else if (e.code == 'channel-error') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text('Campo Senha ou e-mail vazios!')));
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text('Senha muito fraca!')));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithEmailPass(context, String email, String password) async {
    try {
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
          Text('Logado com sucesso!')));
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      print('O código é: ');
      print(e.code);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text('Email inválido!')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text('Senha incorreta!')));
      } else if (e.code == 'channel-error') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text('Campo Senha ou e-mail vazios!')));
      } else if (e.code == 'invalid-credencial') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text('Email ou senha incorretos!')));      }
    }
    catch (e) {
      print(e);
    }
  }

   Future<void> logoutEmailPass(context) async {
     await FirebaseAuth.instance.signOut();
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text('Saindo...')));
     Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
   }

  // Future<void> addNewTaskFirebase(String tarefa) async {
  //   final task = <String, dynamic>{
  //     "tarefa": tarefa,
  //   };
  //
  //   await db.collection("tasks").add(task).then((DocumentReference doc) =>
  //       print('DocumentSnapshot added with ID: ${doc.id}'));
  // }

  // Future<List> listTasksFirebase() async {
  //   List<Object> tarefas = [];
  //
  //   await db.collection("tasks").get().then((event) {
  //     for (var doc in event.docs) {
  //       // print("${doc.id} => ${doc.data()}");
  //       var data = doc.data();
  //       var tarefa = data["tarefa"];
  //       tarefas.add(tarefa.toString());
  //     }
  //   });
  //   return tarefas;
  // }


  Future<void> addNewTaskFirebase(String tarefa) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    final task = <String, dynamic>{
      "tarefa": tarefa,
      "userId": userId,
    };

    await db.collection("tasks").add(task).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<List<String>> listTasksFirebase() async {
    List<String> tarefas = [];
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    await db
        .collection("tasks")
        .where("userId", isEqualTo: userId)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        var data = doc.data();
        var tarefa = data["tarefa"];
        tarefas.add(tarefa.toString());
      }
    });
    return tarefas;
  }

}
