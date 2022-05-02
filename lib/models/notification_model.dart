import 'package:flutter/material.dart';


class NotificationModel extends ChangeNotifier {

  int _number = 0;
  AnimationController? _bounceController;

  int get number => this._number;

  set number( int value ) {
    this._number = value;
    notifyListeners();
  }


  AnimationController get bounceController => this._bounceController!;
  set bounceController( AnimationController controller ) {
    this._bounceController = controller;
    //notifyListeners();
  }

}