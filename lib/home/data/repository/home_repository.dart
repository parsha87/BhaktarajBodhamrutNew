import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/app_repository.dart';
import '../../../data/sharedprefs/constants.dart';
import '../models/bhajans.dart';

class HomeRepository {
  final firestore = FirebaseFirestore.instance;
  final productCollectionRed =
      FirebaseFirestore.instance.collection('babaSBhajans');
  final userCollectionRef = FirebaseFirestore.instance.collection('users');

  List<Bhajans> productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Bhajans.fromMap(e.data()! as Map<String, dynamic>);
    }).toList();
  }

  Stream<List<Bhajans>> get products {
    return productCollectionRed.snapshots().map(productListFromSnapshot);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
