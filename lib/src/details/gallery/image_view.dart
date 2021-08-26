part of 'gallery.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key, required this.images, this.initialIndex = 0})
      : super(key: key);
  final List<Image> images;

  /// Image shown when the dialog loads
  ///
  /// Index should be with the range of [images] else I'll make unnecessary
  /// noise.
  final int initialIndex;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: currentIndex);
    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: widget.images
              .map((e) => Image(
                    image: e.image,
                    fit: BoxFit.contain,
                  ))
              .toList(),
        ),
        Positioned(
          bottom: 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.001),
              focusColor: Colors.white.withOpacity(0.001),
              highlightColor: Colors.white.withOpacity(0.05),
              onTap: currentIndex < 1
                  ? null
                  : () {
                      setState(() {
                        currentIndex--;
                      });
                      controller.animateToPage(currentIndex,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 3,
                child: Center(
                  // child: Icon(
                  //   Icons.arrow_back_ios,
                  //   size: 48,
                  //   color: Colors.black45,
                  // ),
                  child: Container(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.001),
              focusColor: Colors.white.withOpacity(0.001),
              highlightColor: Colors.white.withOpacity(0.05),
              onTap: currentIndex == widget.images.length - 1
                  ? null
                  : () {
                      setState(() {
                        currentIndex++;
                      });
                      controller.animateToPage(currentIndex,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 2 / 3,
                child: Center(
                  // child: Icon(
                  //   Icons.arrow_forward_ios,
                  //   size: 48,
                  //   color: Colors.black45,
                  // ),
                  child: Container(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          child: Material(
            color: Colors.black87,
            child: Row(
              children: List.generate(
                widget.images.length,
                (index) => Expanded(
                  child: InkWell(
                    child: Container(
                      height: 5,
                      color: currentIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      margin: EdgeInsets.all(2),
                    ),
                  ),
                ),
              ),

              // widget.images.asMap().map((e, pos) {
              //   return MapEntry(e, Expanded(
              //     child: InkWell(
              //       child: Container(
              //         height: 5,
              //         color:  Colors.white,
              //         margin: EdgeInsets.all(2),
              //       ),
              //     ),
              //   ));
              // }).values.toList(),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.black38,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}

/// Display images in a full screen dialog
///
///
showImageView({
  required BuildContext context,
  required List<Image> images,
  int initialIndex = 0,
}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => ImageView(
      images: images,
      initialIndex: initialIndex,
    ),
  );
}
