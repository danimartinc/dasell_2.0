import '../../../commons.dart';

class FavAdBtn extends StatelessWidget {

  final dynamic documents;

  const FavAdBtn({Key? key, this.documents}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return IconButton(
      onPressed: () {
        FirebaseFirestore.instance
          .collection('products')
          .doc( documents!['id'].toString())
          .update({'isFav': !documents!['isFav']});
      },
      alignment: Alignment.center,
      icon: documents!['isFav']
        ? Icon(
          Icons.favorite,
          color: Colors.red[700],
        )
        : Icon(
          Icons.favorite_border,
          color: Colors.red[700],
        ),
    );
  }
}