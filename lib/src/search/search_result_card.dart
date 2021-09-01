part of 'search.dart';

class SearchResultCard extends StatelessWidget {
  final Bird bird;

  const SearchResultCard({Key? key, required this.bird}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Image.network(bird.featurePhoto()?.url() ?? ''),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Text(
                    bird.englishName ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    bird.scientificName ?? '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
