import 'package:DaSell/commons.dart';


class ChatRoomVo {
  bool? isRead;
  String? lastMessage;
  String? senderId;
  Timestamp? timeStamp;
  String docId;

  bool get sentByMe {
    return senderId == FirebaseService.get().uid;
  }

  /// no se si es válido
  DateTime? get dateTimeStamp {
    if (timeStamp == null) {
      return null;
    }
    return timeStamp!.toDate();
    // return DateTime.tryParse(timeStamp!);
  }

  ChatRoomVo(
      {this.isRead,
      this.lastMessage,
      this.senderId,
      this.timeStamp,
      required this.docId});

  ChatRoomVo.fromJson(Map<String, dynamic> json) : docId = json['docId'] {
    isRead = json['isRead'];
    lastMessage = json['lastMessage'];
    senderId = json['senderId'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isRead'] = this.isRead;
    data['lastMessage'] = this.lastMessage;
    data['senderId'] = this.senderId;
    data['timeStamp'] = this.timeStamp;
    data['docId'] = this.docId;
    return data;
  }

  String getOtherUserId(String idToRemove) {
    return docId.replaceFirst(idToRemove, '').trim();
  }
}
