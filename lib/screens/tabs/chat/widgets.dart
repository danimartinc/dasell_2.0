import 'package:DaSell/commons.dart';

import '../utils/badge_count.dart';
import 'models.dart';

class ChatRoomItem extends StatelessWidget {
  final ChatViewItemVo data;
  final VoidCallback? onTap;

  const ChatRoomItem({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        key: ValueKey(data.widgetId),
        leading: ChatItemAvatar(imageUrl: data.imageUrl),
        title: Text(data.title, style: kChatItemTitleStyle),
        subtitle: Text(data.subtitle),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.textTime,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 6),
            // request temporal para conseguir el
            // badge count del query.
            // BadgeRequester(
            //   recieverId: 'receiverId',
            //   docId: 'docId',
            //   uid: 'uid',
            // ),
            BadgeCount(count: data.unreadCount),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class ChatItemAvatar extends StatelessWidget {
  final String? imageUrl;

  const ChatItemAvatar({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl?.isNotEmpty == true;
    if (!hasImage) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.antiAlias,
        child: SvgPicture.asset('assets/images/boy.svg'),
      );
    }
    return CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(imageUrl!),
    );
  }
}
