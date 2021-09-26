import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zim_birds/src/details/detail_page.dart';
import 'package:zim_birds/src/models/bird_model.dart';

class FeaturedCard extends StatelessWidget {
  final Bird bird;
  const FeaturedCard({Key? key, required this.bird}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DetailPage(bird: bird,))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: '${bird.featurePhoto()?.url()}',
                fit: BoxFit.cover,
                width: double.infinity,
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
                  child: Text(
                    '${bird.englishName}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
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
