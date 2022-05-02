import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



List<List<Marker>> allMarkers = [
  [Marker(markerId: MarkerId('myMarker1'), position: LatLng(-34, 151))],
  [Marker(markerId: MarkerId('myMarker2'), position: LatLng(40.7128, -74.0060))],
  [Marker(markerId: MarkerId('myMarker3'), position: LatLng(35.652832, 139.839478))],
];

class MapPrueba extends StatefulWidget {

  final String title;
  const MapPrueba({Key? key, required this.title}) : super(key: key);
  @override
  _MapPruebaState createState() => _MapPruebaState();
}

class _MapPruebaState extends State<MapPrueba> {
  
  PageController _pageViewMapsController = PageController();
  Timer? _timerPager;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () => _timerPagerStart());
  }

  _timerPagerStart() {
    if (_timerPager == null) {
      _timerPager = Timer.periodic(const Duration(seconds: 5), (timer) {
        try {
          _callNextViewPagerPage();
        } catch (e) {
          _timerPager?.cancel();
          _timerPager = null;
        }
      });
    }
  }

  _callNextViewPagerPage() {
    if (_pageViewMapsController.page != 2) {
      _pageViewMapsController.nextPage(duration: kTabScrollDuration, curve: Curves.ease);
    }
    else {
      _pageViewMapsController.animateToPage(0, duration: kTabScrollDuration, curve: Curves.ease);
    }
  }

  Widget buildPageView() {
    final size = MediaQuery.of(context).size;

    print("???rebuild");

    return PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageViewMapsController,
        itemCount: 3,
        itemBuilder: (context, index) {
          final realIndex = index;
          return Center(
            child: SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.9,
              child: GoogleMap(
                compassEnabled: false,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
                indoorViewEnabled: false,
                //keepAlive: true,
                markers: Set.from(allMarkers[realIndex]),
                initialCameraPosition: CameraPosition(
                  target: allMarkers[realIndex][0].position,
                  zoom: 10.0,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: buildPageView());
}
