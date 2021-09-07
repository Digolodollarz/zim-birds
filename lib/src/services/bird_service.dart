import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:zim_birds/src/models/bird_model.dart';

const allPath = 'all';
const featuredPath = 'featured';

class BirdService with ChangeNotifier {
  final fire = FirebaseFirestore.instance;
  bool searching = false;

  List<Bird>? all;
  List<Bird>? featured;
  List<Bird>? popular;
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
  getAll() async {
    fire.collection(allPath).snapshots().listen((event) {
      final birds = event.docs.map<Bird>((e) => Bird.fromFire(e)).toList();
      this.all = birds;
      this.notifyListeners();
    });
    fire
        .collection(allPath)
        .limit(20)
        .orderBy('featured', descending: true)
        .snapshots()
        .listen((event) {
      final birds = event.docs.map<Bird>((e) => Bird.fromFire(e)).toList();
      print(birds);
      this.featured = birds;
      this.notifyListeners();
    });
    fire
        .collection(allPath)
        .orderBy('views', descending: true)
        .limit(20)
        .snapshots()
        .listen((event) {
      final birds = event.docs.map<Bird>((e) => Bird.fromFire(e)).toList();
      this.popular = birds;
      print(birds);
      this.notifyListeners();
    });
  }

  /// Update view count on a bird
  ///
  /// todo: Limit views by a user
  view(Bird bird) async {
    print('Updating');
    fire
        .collection(allPath)
        .doc(bird.scientificName)
        .update({'views': FieldValue.increment(1)}).then(
      (value) => print('Updated'),
    );
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
        final v = '${bird.scientificName}${bird.englishName}${bird.family}'
            .toLowerCase()
            .contains('$query'.toLowerCase());
        return v;
      }).toList();
      this.results = birds;
      this.notifyListeners();
    } finally {
      searching = false;
    }
  }
}
