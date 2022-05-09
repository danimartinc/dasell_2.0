import '../../commons.dart';




class ModalOptions  extends StatefulWidget {

  final VoidCallback onTap;

  const ModalOptions({Key? key, required this.onTap}) : super(key: key);

  _ModalOptionsState createState() => _ModalOptionsState();
}

class _ModalOptionsState extends State<ModalOptions> {


  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert, color: Theme.of(context).primaryColor,),
              onPressed: () => _onButtonPressed(), 
            ),
            Text(
              _selectedItem,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed() {

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 140,
            child: Container(
              child: Column(
                children: [ 
                  BottomNavigationMenu(icon: Icon(Icons.ac_unit),text: Text('Editar opinión'), onTap: () {  }, ),
                  BottomNavigationMenu(icon: Icon(Icons.accessibility_new),text: Text('Eliminar opinión'), onTap: () {  }),
                ]),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

}

class BottomNavigationMenu extends StatelessWidget {

  final VoidCallback onTap;
  final Icon icon;
  final Text text;

  const BottomNavigationMenu({Key? key, required this.onTap, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

        return ListTile(
          leading: icon,
          title: text,
          onTap: onTap,
        );
  }
}