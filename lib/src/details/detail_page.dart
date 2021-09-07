import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zim_birds/src/details/audio/audio_page.dart';
import 'package:zim_birds/src/models/bird_model.dart';
import 'package:zim_birds/src/services/bird_service.dart';
import 'gallery/gallery.dart';

class DetailPage extends StatefulWidget {
  final Bird bird;

  const DetailPage({Key? key, required this.bird}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<BirdService>(context, listen: false).view(widget.bird);
  }

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
                  image: NetworkImage('${widget.bird.photos?.first.url()}'),
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
                        widget.bird.englishName ?? '',
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
                                Tab(text: 'Recordings'),
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
                                    child: Overview(bird: widget.bird),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        ImageGrid(
                                          images: List.generate(
                                            widget.bird.photos?.length ?? 0,
                                            (index) => Image.network(
                                              '${widget.bird.photos![index].url()}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: AudioPage(
                                    files: widget.bird.recordings ?? [],
                                  )),
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

class Overview extends StatelessWidget {
  final Bird bird;

  const Overview({Key? key, required this.bird}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Scientific Name: ',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Flexible(child: Text(bird.scientificName ?? 'Unknown')),
            ],
          ),
          Row(
            children: [
              Text(
                'Family: ',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Flexible(child: Text(bird.family ?? 'Unknown')),
            ],
          ),
        ],
      ),
    );
  }
}
