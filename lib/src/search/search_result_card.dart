part of 'search.dart';

class SearchResultCard extends StatelessWidget {
  final Bird bird;

  const SearchResultCard({Key? key, required this.bird}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailPage(
                bird: bird,
              ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
                child: CachedNetworkImage(
                  imageUrl: bird.featurePhoto()?.url() ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
