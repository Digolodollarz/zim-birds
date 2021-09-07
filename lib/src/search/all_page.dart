part of 'search.dart';

class AllPage extends StatefulWidget {
  final SearchType searchType;

  const AllPage({Key? key, required this.searchType}) : super(key: key);

  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  @override
  void initState() {
    super.initState();
    // Provider.of<BirdService>(context, listen: false).search(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BirdService>(
      builder: (context, birdService, _) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: AppTheme.padding),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: Icon(Icons.arrow_back_ios)),
                    Text(
                      widget.searchType == SearchType.FEATURED
                          ? 'Featured birds'
                          : 'Popular birds',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    final birds = widget.searchType == SearchType.FEATURED
                        ? birdService.featured ?? []
                        : birdService.popular ?? [];
                    return ListView.separated(
                      itemBuilder: (context, position) {
                        return SearchResultCard(bird: birds[position]);
                      },
                      itemCount: birds.length,
                      separatorBuilder: (context, _) => SizedBox(height: 16),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
