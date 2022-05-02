import '../../../commons.dart';

import 'package:multi_image_picker2/multi_image_picker2.dart';

import 'package:DaSell/screens/add/add_images/adding_images_state.dart';


import '../../../widgets/ui/animations/animations.dart';
import 'widgets/widgets.dart';


class AddingImagesScreen extends StatefulWidget {

  static const routeName = './adding_images_screen';

  @override
  createState() => _AddingImagesScreenState();
}

class _AddingImagesScreenState extends AddingImagesScreenState {

  int current = 0;
  
  @override
  Widget build(BuildContext context) {

        return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text('Añade imágenes del producto'),
      ),
      body: Stack(
         alignment: Alignment.bottomCenter,
        children: [ Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Column(
                children: [
                  kGap50,
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: list.isEmpty
                      ? Center(
                        child: Text('No hay imágenes seleccionadas'),
                      )
                      : Stack(
                        children: [
                          CarouselSlider(
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
                          ),
                          Positioned(
                            bottom: 5,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: isCamera
                                ? pathList.map((url) {
                                        
                                  int index = pathList.indexOf(url);
                                  
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: current == index
                                                ? Theme.of(context).scaffoldBackgroundColor
                                                : Colors.grey,
                                          ),
                                  );
                                }).toList()
                                : images.map((url) {
                                  
                                  int index = images.indexOf(url);
                                  
                                  return Container(
                                    width: 80.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: current == index
                                        ? Theme.of(context).scaffoldBackgroundColor
                                        : Colors.grey,
                                    ),
                                  );
                                }).toList(),
                            ),
                          )
                        ]
                      ),
                  ),
                  ControlCameraBtn(loadAssets: loadAssets, takePicture: takePicture,),
                  kGap10,
                  BoardMessage(),
                ],
              ),
              Positioned(
                  child: OpacityTween(
                    child: SlideUpTween(
                      begin: const Offset(-30, 60),
                      child: NextScreenBtn(onPressed: submitImage, )
                    ),
                  ),
                ),
                Positioned(
                  child: const OpacityTween(
                    child: SlideUpTween(
                      begin: Offset(-30, 60),
                      child: IgnorePointer(
                        child: Text(
                          'Siguiente',
                          style: bookButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),     
          ],
        ),
        ],
      ),
    );
       },
    );
  }
}