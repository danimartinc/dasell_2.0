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


class SearchAdsBtn extends StatelessWidget {

  const SearchAdsBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No hay productos añadidos como favoritos',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18)  
          ),
          kGap20,
          Text('Productos que te gustan'),
          Text('Para guardar un producto, pulsa el icono de producto favorito'),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon( FontAwesomeIcons.heart ),
              ],
            ),
          ),
          kGap30,
          MaterialButton(
            minWidth: width - 180,
            child: Text('Buscar producto', style: TextStyle( color: Colors.white ) ),
            color: Theme.of(context).primaryColor,
            //Redondeamos los bordes del botón
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {
              Provider.of<MenuProvider>( context, listen: false ).setIndex(0);
            }
          ),
        ],
      ),
    );
  }
}