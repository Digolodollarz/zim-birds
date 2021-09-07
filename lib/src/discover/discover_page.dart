import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zim_birds/src/models/bird_model.dart';
import 'package:zim_birds/src/services/bird_service.dart';
import 'dart:async';
import 'package:async/async.dart';

import 'featured_card.dart';
import 'popular_card.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final fire = FirebaseFirestore.instance;
  Stream<QuerySnapshot<dynamic>>? all;

  // getAll() {
  //   // fire.collection(allPath).snapshots().listen((event) {
  //   //   final birds = event.docs.map<Bird>((e) => Bird.fromFire(e)).toList();
  //   //   this.all = birds;
  //   //   this.notifyListeners();
  //   // });
  //   final first5 = fire.collection(allPath).limit(2).snapshots();
  //   final first1 = fire.collection('keyed').limit(3).snapshots();
  //   return Observable.merge([first1, first5]).;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   all = getAll();
  //   all?.listen((event) {print('All: ${event.docs.length}');});
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Consumer<BirdService>(builder: (context, birdService, _) {
            return Column(
              children: [
                Text(
                  'Hey John! What are you going to watch today?',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Popular birds',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    InkWell(child: Text('See all')),
                  ],
                ),
                SizedBox(height: 10),
                Builder(builder: (context) {
                  if (birdService.popular == null)
                    return CircularProgressIndicator();
                  final birds = birdService.popular!;
                  if (birds.length == 0) return Text('Error');
                  return Container(
                    height: 200,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) =>
                          PopularCard(bird: birds[position]),
                      separatorBuilder: (context, position) =>
                          SizedBox(width: 10),
                      itemCount: birds.length,
                    ),
                  );
                }),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Featured birds',
                      style: Theme.of(context).textTheme.headline5,
                    )),
                    InkWell(
                        child: Text(
                      'See all',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Theme.of(context).primaryColor),
                    )),
                  ],
                ),
                SizedBox(height: 10),
                Builder(builder: (context) {
                  if (birdService.featured == null)
                    return CircularProgressIndicator();
                  final birds = birdService.featured!;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, position) =>
                        FeaturedCard(bird: birds[position]),
                    separatorBuilder: (context, position) =>
                        SizedBox(height: 10),
                    itemCount: birds.length,
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
