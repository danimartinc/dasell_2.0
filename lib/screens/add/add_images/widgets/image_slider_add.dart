import '../../../../commons.dart';


class AddImageSlider extends StatelessWidget {

  const AddImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //bool isCamera = true;
    //List<Asset> images = <Asset>[];
   // var list = [];
    //String? _error;

    
    //File? storedImage;
    //File? pickedImage;
    //List<File> pathList = [];

    return Container();
/*
    return CarouselSlider(
      items: isCamera
                                ? pathList.map((e) {
                                    return Image.file(e);
                                  }).toList()
                                : List.generate(images.length, (index) {
                                    Asset asset = images[index];
                                    return AssetThumb(
                                      asset: asset,
                                      width: 20,
                                      height: 250,
                                    );
                                }
                                ),
                            options: CarouselOptions(
                              height: 400.0,
                              aspectRatio: 16/9,
                              viewportFraction: 0.5,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration( seconds: 15 ),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  current = index;
                                });
                              },
                            ),
                          );*/
  }
}