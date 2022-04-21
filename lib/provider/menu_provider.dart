import 'package:DaSell/commons.dart';

class MenuProvider extends ChangeNotifier{

  int index = 0;

  void setIndex ( int index ){
    this.index = index;
    notifyListeners();
  }
}