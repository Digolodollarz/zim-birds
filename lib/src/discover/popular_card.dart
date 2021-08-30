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
          .push(MaterialPageRoute(builder: (context) => DetailPage())),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Image.asset(
                'assets/stock/african_fish_eagle.jpeg',
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
                  child: Text(
                    'African Fish Eagle',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
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
