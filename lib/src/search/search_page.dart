part of 'search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BirdService>(builder: (context, birdService, _) {
      if (birdService.searching) return CircularProgressIndicator();
      final birds = birdService.all!;
      return Container(
        child: ListView.builder(
          itemBuilder: (context, position) {
            return SearchResultCard(bird: birds[position]);
          },
          itemCount: birds.length,
        ),
      );
    });
  }
}
