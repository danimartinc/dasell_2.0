import 'package:DaSell/widgets/home/widgets/widgets.dart';

import '../../commons.dart';


import '../../screens/home/product_detail_screen.dart';


class AdItem extends StatefulWidget {

  final dynamic documents;
  final bool isMe;
  final String myId;

  AdItem(
    this.documents,
    this.isMe,
    this.myId,
  );
  
  @override
  _AdItemState createState() => _AdItemState();

}

class _AdItemState extends State<AdItem> {

  
  @override
  Widget build( BuildContext context ) {
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
            arguments: {
              'docs': widget.documents,
              'isMe': widget.isMe,
            },
        ),
        child: GridTile(
          child: Hero(
            tag: widget.documents['id'],
            child: CachedNetworkImage(
              imageUrl: widget.documents['images'][0],
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          header: !widget.isMe
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 6, 2, 0),
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade900,
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            5.0, // Move to right 10  horizontally
                            5.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                    ),
                    child:  FavAdBtn( documents: widget.documents,)
                  
                  ),
                )
              : null,
          footer: AdItemFooter( documents: widget.documents, )
        ),
      ),
    );
  }
}
