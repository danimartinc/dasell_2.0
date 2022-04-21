import '../../../../commons.dart';

class ChooseLocationButton extends StatelessWidget {

  final VoidCallback getUserLocation;
  final VoidCallback openMapsScreen;
  const ChooseLocationButton({Key? key, required this.getUserLocation, required this.openMapsScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          label: Text( 'Ubicación actual', ),
          onPressed: getUserLocation,
          icon: Icon(
            Icons.location_on_outlined,
          ),
          style: TextButton.styleFrom(
            primary: Theme.of( context ).primaryColor,
          ),       
        ),
        TextButton.icon(
          label: Text( 'Elegir ubicación' ),
          onPressed: openMapsScreen,
          icon: Icon(
            Icons.map,
          ),
          style: TextButton.styleFrom(
            primary: Theme.of( context ).primaryColor,
          ),
        
        ),
      ],
    );
  }
}