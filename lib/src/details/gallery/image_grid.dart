part of 'gallery.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key, required this.images}) : super(key: key);

  final List<Image> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (_, index) => Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () => showImageView(
                context: context, images: images, initialIndex: index),
            child: images[index],
          ),
        ),
        itemCount: images.length,
      ),
    );
  }
}
