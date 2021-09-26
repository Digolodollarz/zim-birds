import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zim_birds/src/models/bird_model.dart';
import 'package:zim_birds/src/search/search.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Consumer<BirdService>(builder: (context, birdService, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Zim Birds',
                  style: Theme.of(context).textTheme.headline4,
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
                    InkWell(
                      child: Text(
                        'See all',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AllPage(searchType: SearchType.POPULAR))),
                    ),
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
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AllPage(searchType: SearchType.FEATURED))),
                    ),
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
