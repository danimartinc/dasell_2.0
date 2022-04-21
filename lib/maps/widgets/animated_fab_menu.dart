import 'package:DaSell/maps/widgets/btn_follow_user.dart';
import 'package:DaSell/maps/widgets/btn_shared.dart';
import 'package:DaSell/maps/widgets/btn_toggle_user_route.dart';
import 'package:flutter/material.dart';

import 'btn_location.dart';

class AnimatedFabMenu extends StatefulWidget {
  @override
  _AnimatedFabMenuState createState() => _AnimatedFabMenuState();
}

class _AnimatedFabMenuState extends State<AnimatedFabMenu>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation? rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController!);

    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController!);

    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController!);

    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut));

    super.initState();

    animationController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 30,
            bottom: 30,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                IgnorePointer(
                  child: Container(
                    color: Colors.transparent,
                    height: 150.0,
                    width: 150.0,
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(285),
                      degOneTranslationAnimation!.value * 100),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation!.value))
                      ..scale(degOneTranslationAnimation!.value),
                    alignment: Alignment.center,
                    child: BtnToggleUserRoute(),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(240),
                      degTwoTranslationAnimation!.value * 100),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation!.value))
                      ..scale(degTwoTranslationAnimation!.value),
                    alignment: Alignment.center,
                    child: BtnFollowUser(),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(195),
                      degThreeTranslationAnimation!.value * 100),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation!.value))
                      ..scale(degThreeTranslationAnimation!.value),
                    alignment: Alignment.center,
                    child: BtnCurrentLocation(),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(155),
                      degThreeTranslationAnimation!.value * 100),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation!.value))
                      ..scale(degThreeTranslationAnimation!.value),
                    alignment: Alignment.center,
                    child: BtnShared(),
                  ),
                ),
                Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimation!.value)),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 25,
                    child: IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () {
                          if (animationController!.isCompleted) {
                            animationController!.reverse();
                          } else {
                            animationController!.forward();
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
