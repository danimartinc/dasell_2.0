import 'package:DaSell/commons.dart';

extension StateExtension on State {
  bool update() {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(() {});
    }
    return mounted;
  }
}

extension BuildContextExt on BuildContext {
  Future<T?> pushReplacementNamed<T>(String routeName, {bool useRoot = false}) {
    return Navigator.of(this, rootNavigator: useRoot)
        .pushReplacementNamed(routeName);
  }

  void pop<T>({bool rootNavigator = false, T? result}) {
    Navigator.of(this, rootNavigator: rootNavigator).pop<T>(result);
  }

  void popUntil(RoutePredicate callback, {bool rootNavigator = false}) {
    final nav = Navigator.of(this, rootNavigator: rootNavigator);
    nav.popUntil(callback);
  }

  bool canPop({bool rootNavigator = false}) {
    return Navigator.of(this, rootNavigator: rootNavigator).canPop();
  }

  Future<T?> push<T>(
    Widget page, {
    String? name,
    Object? args,
    bool rootNavigator = false,
  }) {
    name ??= '$page';
    final nav = Navigator.of(this, rootNavigator: rootNavigator);
    return nav.push<T>(
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: name, arguments: args),
        fullscreenDialog: false,
      ),
    );
  }

  Future<T> dialogSafe<T>(
    Widget page,
    T defaultReturn, {
    String? name,
    Object? args,
    bool rootNavigator = false,
  }) async {
    final result = await dialog<T>(
      page,
      name: name,
      args: args,
      rootNavigator: rootNavigator,
    );
    trace("RESULTADO: ", result);
    return result ?? defaultReturn;
  }

  Future<T?> dialog<T>(
    Widget page, {
    String? name,
    Object? args,
    bool rootNavigator = false,
  }) {
    return showDialog<T>(
      context: this,
      routeSettings: RouteSettings(
        arguments: args,
        name: name,
      ),
      builder: (context) => page,
    );
  }
}
