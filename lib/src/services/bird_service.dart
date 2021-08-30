import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:zim_birds/src/models/bird_model.dart';

const allPath = 'all';

class BirdService with ChangeNotifier {
  final fire = FirebaseFirestore.instance;

  List<Bird>? all;

  BirdService() {
    this.init();
  }

  init() {
    this.getAll();
  }

  getAll() {
    fire.collection(allPath).limit(20).snapshots().listen((event) {
      print('docs');
      print(event.docs);
      final birds = event.docs.map<Bird>((e) => Bird.fromFire(e)).toList();
      this.all = birds;
      print(this.all);
      this.notifyListeners();
    });
  }
}
