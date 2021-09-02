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

  /// Fetches all documents from Cloud Firestore
  ///
  /// The local bird list will be used to search
  getAll() {
    fire.collection(allPath).snapshots().listen((event) {
      final birds = event.docs.map<Bird>((e) => Bird.fromFire(e)).toList();
      this.all = birds;
      this.notifyListeners();
    });
  }

  /// Search for a bird
  ///
  /// [query] - String to be searched across multiple fields on the
  /// bird info. Something akin to contains.
  ///
  /// Search is done against a local list, due to the way FireStore handles
  /// searching. This is some low level attempt at a fuzzy matching algorithm.
  search(String query) async {
    print('Querying $query');
    searching = true;
    this.notifyListeners();
    try {
      final birds = this.all!.where((bird) {
        return bird
            .toJson()
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      this.results = birds;
      this.notifyListeners();
    } finally {
      searching = false;
    }
  }
}
