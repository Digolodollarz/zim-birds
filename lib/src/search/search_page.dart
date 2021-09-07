part of 'search.dart';

class SearchPage extends StatefulWidget {
  final SearchType searchType;
  const SearchPage({Key? key, required this.searchType}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Provider.of<BirdService>(context, listen: false).search(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BirdService>(
      builder: (context, birdService, _) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecorations.search,
                  onChanged: (value) => birdService.search(value),
                ),
                SizedBox(height: AppTheme.padding),
                Expanded(
                  child: Builder(builder: (context) {
                    if (birdService.searching) return CircularProgressIndicator();
                    if (birdService.results == null ||
                        birdService.results!.length == 0) {
                      return Text('No results found. Please try another query');
                    }
                    final birds = birdService.results!;
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

class InputDecorations {
  static InputDecoration search = InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
    AppTheme.borderRadius,
  )));
}

enum SearchType{
  SEARCH, FEATURED, POPULAR
}
