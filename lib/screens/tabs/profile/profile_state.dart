import 'package:DaSell/screens/tabs/profile/widgets/deleteuser_dialog.dart';

import '../../../commons.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pPath;
import 'package:google_sign_in/google_sign_in.dart';

import 'widgets/signout_dialog.dart';


abstract class ProfileScreenState extends State<ProfileScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  User? userId = FirebaseAuth.instance.currentUser;
  

  void pickImage( BuildContext context, ImageSource src ) async {
    
    File? storedImage;
    File? pickedImage;
    bool isLoading = false;

    final picker = new ImagePicker();

    final XFile? pickedImageFile =
        await picker.pickImage(source: src, maxWidth: 600, imageQuality: 70);

    if (pickedImageFile == null) {
      return;
    }

    storedImage = File(pickedImageFile.path);

    //Parte importante
    final appDir = await pPath.getApplicationDocumentsDirectory();
    final fileName = path.basename( storedImage.path);
    final savedImage = await storedImage.copy('${appDir.path}/$fileName');
    pickedImage = savedImage;


    setState(() {
      isLoading = true;
    });

    await Provider.of<AdProvider>(context, listen: false)
        .uploadProfilePicture( pickedImage );

    setState(() {
      isLoading = false;
    });
  
  }


  void setStatus( String status ) async{

      await _firestore.collection('users').doc( uid ).update({
        'status': status,
      });
  }

  void onSignOutDialogPressed() {
    showDialog(
      context: context,
      builder: (context) => SignOutDialog(
        onSelect: signOut,
      ),
    );
  }

  void signOut( int option ) async {
      
      if( option == 1 ) {

        setStatus('Desconectado');

        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();

      }    
  }

  /*Future<void> deleteAds() async {
    
    final res = await _firestore
        .collection('products')
        .where('uid', isEqualTo: uid)
        .get();

    final batcher = _firestore.batch();
    
    res.docs.forEach((d) {
      batcher.delete(d.reference, );
    });
    batcher.commit();
    
    //return list.forEach(( doc ) => doc.delete() );
    //return list.forEach( () => delete(list) );
    //return list.map((e) => ResponseProductVo.fromJson(e.data())).toList();
  }*/

  void onDeleteUserDialogPressed() {
    showDialog(
      context: context,
      builder: (context) => DeleteUserDialog(
        onSelect: deleteUser,
      ),
    );
  }

  Future<void> deleteUser( int option ) async {

    if( option == 1 ) {
    
      try {

        final res = await _firestore
          .collection('products')
          .where('uid', isEqualTo: uid)
          .get();

        final batcher = _firestore.batch();
        
        res.docs.forEach((d) {
          batcher.delete(d.reference, );
        });

        batcher.commit();

        await FirebaseFirestore.instance
          .collection('users')
          .doc(
            uid.toString(),
          )
          .delete()
          .then((value) => print("Delete User"))
          .catchError((error) => print("Failed to delete user: $error"));

  
        await FirebaseAuth.instance.signOut();
          
      } catch (e) {
        print(e);
      }
  
    }
  }
}

 