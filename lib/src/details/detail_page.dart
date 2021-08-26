import 'package:flutter/material.dart';
import 'gallery/gallery.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double bgHeight = 400 < screenHeight / 2 ? 400 : screenHeight / 2;
    return Material(
      child: Stack(
        children: [
          Container(
            height: bgHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/stock/african_fish_eagle.jpeg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: bgHeight - 96),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black45],
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'African Fish Eagle',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              tabs: [
                                Tab(text: 'Overview'),
                                Tab(text: 'Gallery'),
                                Tab(text: 'Ratings'),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              constraints: BoxConstraints(
                                maxHeight: screenHeight * 0.8,
                              ),
                              child: TabBarView(
                                children: [
                                  Container(
                                    child: Text(africanFishEagleDetails),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        ImageGrid(
                                          images: List.generate(
                                            4,
                                            (index) => Image.asset(
                                              'assets/stock/african_fish_eagle.jpeg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: MediaQuery.of(context).padding.left,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

final String africanFishEagleDetails = '''
The African fish eagle (Haliaeetus vocifer) or the African sea eagle, is a large species of eagle found throughout sub-Saharan Africa wherever large bodies of open water with an abundant food supply occur. It is the national bird of Namibia and Zambia.

As a result of its large range, it is known in many languages. Examples of names include: nkwazi in Chewa, aigle pêcheur in French, hungwe in Shona, inkwazi in isiZulu, and 'ntšhu' (pronounced "ntjhu") in Northern Sotho. 

This species may resemble the bald eagle in appearance; though related, each species occurs on different continents, with the bald eagle being resident in North America.''';
