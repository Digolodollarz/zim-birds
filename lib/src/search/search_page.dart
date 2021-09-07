part of 'search.dart';

class SearchPage extends StatefulWidget {
  final SearchType searchType;

  const SearchPage({Key? key, required this.searchType}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  // TODO: Add _kAdIndex
  static final _kAdIndex = 4;

  // TODO: Add a BannerAd instance
  late BannerAd _ad;

  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // Provider.of<BirdService>(context, listen: false).search(' ');

    // TODO: Create a BannerAd instance
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    // TODO: Load an ad
    _ad.load();
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
                    if (birdService.searching)
                      return CircularProgressIndicator();
                    if (birdService.results == null ||
                        birdService.results!.length == 0) {
                      return Text('No results found. Please try another query');
                    }
                    final birds = birdService.results!;
                    return ListView.separated(
                      itemBuilder: (context, position) {
                        if ((position + 1) % 5 == 0)
                          return Column(
                            children: [
                              Container(
                                child: AdWidget(
                                    ad: BannerAd(
                                  adUnitId: AdHelper.bannerAdUnitId,
                                  size: AdSize.banner,
                                  request: AdRequest(),
                                  listener: BannerAdListener(
                                    onAdLoaded: (_) {
                                      setState(() {
                                        _isAdLoaded = true;
                                      });
                                    },
                                    onAdFailedToLoad: (ad, error) {
                                      // Releases an ad resource when it fails to load
                                      ad.dispose();

                                      print(
                                          'Ad load failed (code=${error.code} message=${error.message})');
                                    },
                                  ),
                                )..load()),
                                width: _ad.size.width.toDouble(),
                                height: 72.0,
                                alignment: Alignment.center,
                              ),
                              SearchResultCard(bird: birds[position]),
                            ],
                          );
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

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _ad.dispose();

    super.dispose();
  }

  // TODO: Add _getDestinationItemIndex()
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }
}

class InputDecorations {
  static InputDecoration search = InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
    AppTheme.borderRadius,
  )));
}

enum SearchType { SEARCH, FEATURED, POPULAR }
