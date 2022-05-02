import 'package:DaSell/commons.dart';

class TabMenuProvider extends ChangeNotifier {

  int index = 0;

  void setIndex ( int index ){
    this.index = index;
    notifyListeners();
  }
}