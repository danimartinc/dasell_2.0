import '../../commons.dart';
import 'package:image_picker/image_picker.dart';



class ImagePickerButton extends StatelessWidget {

  final bool isLoading;
  final BuildContext ctx;
  final Function pickImage;
  final String? profilePic;

  //Constructor
  ImagePickerButton({
    required this.isLoading,
    required this.ctx,
    required this.pickImage,
    this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6, 2, 0),
      alignment: Alignment.centerRight,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber,
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
        child: isLoading
            ? CircularProgressIndicator()
            : IconButton(
                onPressed: () {
                  showDialog(
                    context: ctx,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                pickImage(
                                  ctx,
                                  ImageSource.camera,
                                );
                                Navigator.of(ctx).pop();
                              },
                              title: Text('Cámara'),
                            ),
                            ListTile(
                              onTap: () {
                                pickImage(
                                  ctx,
                                  ImageSource.gallery,
                                );
                                Navigator.of(ctx).pop();
                              },
                              title: Text('Galería'),
                            ),
                            if ( profilePic != '')
                              ListTile(
                                onTap: () {
                                  Provider.of<AdProvider>(ctx, listen: false)
                                      .uploadProfilePicture(null);
                                  
                                  Navigator.of(ctx).pop();
                                },
                                title: Text('Eliminar'),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
                alignment: Alignment.center,
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
