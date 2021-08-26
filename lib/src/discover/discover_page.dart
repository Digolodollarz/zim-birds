import 'package:flutter/material.dart';

import 'featured_card.dart';
import 'popular_card.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
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
              Container(
                height: 200,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) => PopularCard(),
                  separatorBuilder: (context, position) => SizedBox(width: 10),
                  itemCount: 5,
                ),
              ),
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
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).primaryColor
                    ),
                  )),
                ],
              ),
              SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, position) => FeaturedCard(),
                separatorBuilder: (context, position) => SizedBox(height: 10),
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
