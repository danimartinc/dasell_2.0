import 'package:DaSell/commons.dart';

class ProductImageSlider extends StatelessWidget {
  final List<String> images;
  final Function(int) onChanged;

  const ProductImageSlider({
    Key? key,
    required this.images,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (ctx, int i, __) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          width: double.infinity,
          height: 200,
          child: CachedNetworkImage(
            imageUrl: images[i],
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      },
      options: CarouselOptions(
        height: 300.0,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 15),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          onChanged(index);
          // setState(() {
          //   current = index;
          // });
        },
      ),
    );
  }
}

class SliderDots extends StatelessWidget {
  final List<String> images;
  final int current;

  const SliderDots({
    Key? key,
    required this.images,
    this.current = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      left: 0,
      right: 0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map(
            (url) {
              int index = images.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: current == index
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Colors.grey,
                ),
              );
            },
          ).toList()),
    );
  }
}
