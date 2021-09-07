import 'package:flutter/material.dart';
import 'package:zim_birds/src/details/detail_page.dart';
import 'package:zim_birds/src/models/bird_model.dart';

class PopularCard extends StatelessWidget {
  final Bird bird;

  const PopularCard({Key? key, required this.bird}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DetailPage(bird: bird,))),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Image.network(
                '${bird.featurePhoto()?.url()}',
                fit: BoxFit.cover,
                height: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black45],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bird.scientificName ?? '',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.white,
                          fontSize: 12
                            ),
                      ),
                      Text(
                        bird.englishName ?? '',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
