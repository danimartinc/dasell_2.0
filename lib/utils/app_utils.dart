import 'dart:developer' as dev;

import 'package:timeago/timeago.dart' as timeago;

/// Using trace() as a replacement of print() to avoid debug calls compilation.
trace(
  dynamic arg1, [
  dynamic arg2,
  dynamic arg3,
  dynamic arg4,
  dynamic arg5,
  dynamic arg6,
  dynamic arg7,
  dynamic arg8,
  dynamic arg9,
  dynamic arg10,
]) {
  final outputList = <String>[
    '$arg1',
    if (arg2 != null) '$arg2',
    if (arg3 != null) '$arg3',
    if (arg4 != null) '$arg4',
    if (arg5 != null) '$arg5',
    if (arg6 != null) '$arg6',
    if (arg7 != null) '$arg7',
    if (arg8 != null) '$arg8',
    if (arg9 != null) '$arg9',
    if (arg10 != null) '$arg10',
  ];
  // •·
  var msg = outputList.join(',');
  dev.log(
    msg,
    name: 'DaSell',
    time: DateTime.now(),
    level: 0,
  );
}

/// Usa clase global para poner helpers aca.
abstract class AppUtils {
  static String getTimeAgoText(DateTime date) {
    // return '3 minutes ago';
    return timeago.format(date, locale: 'es');
  }

  static String publicationDate(DateTime? date) {
    if(date==null){
      return 'algun dia';
    }
    final day = date.day.toString();
    final month = _monthsById[date.month] ?? '-';
    return '$day $month';
  }

  static final Map<int, String> _monthsById = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };
}

firebaseToJson(e) {
  // jsonEncode(data, toEncodable: (e) {
//   if (e is Timestamp) {
//     return e.toDate().toString();
//   } else {
//     trace("WTF? ", e.runtimeType);
//     return null;
//   }
// });
}
