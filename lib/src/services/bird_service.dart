import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:zim_birds/src/models/bird_model.dart';

const allPath = 'all';

class BirdService with ChangeNotifier {
  final fire = FirebaseFirestore.instance;
  bool searching = false;

  List<Bird>? all;
  List<Bird>? results;

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

  /// Query CloudFirestore
  ///
  /// [query] - String to be searched across multiple fields on the
  /// bird info. Something akin to contains.
  search(String query) async {
    searching = true;
    this.notifyListeners();
    try {
      final snapshot = await fire.collection(allPath).limit(20).get();
      print('docs');
      print(snapshot);
      final birds = snapshot.docs.map<Bird>((e) => Bird.fromFire(e)).toList();
      this.results = birds;
      this.notifyListeners();
    } finally {
      searching = false;
    }
  }
}
