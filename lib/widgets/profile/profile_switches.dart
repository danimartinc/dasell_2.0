import '../../commons.dart';

import 'package:theme_provider/theme_provider.dart';




class ProfileSwitches extends StatefulWidget  {
  
  @override
  _ProfileSwitchesState createState() => _ProfileSwitchesState();
}

class _ProfileSwitchesState extends State<ProfileSwitches> {
  
  bool isDark = false;
  bool notification = true;

  @override
  void didChangeDependencies() {
    
    isDark = ThemeProvider.controllerOf(context).currentThemeId == 'dark_theme'
    ? true
    : false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SwitchListTile.adaptive(
          title: Text(
            'Tema oscuro',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          activeColor: Theme.of(context).primaryColor,
          value: isDark,
          onChanged: (value) async {

            setState(() {
              isDark = value;
            });
            
            ThemeProvider.controllerOf(context).setTheme(
              isDark ? 'dark_theme' : 'light_theme',
            );

            await ThemeProvider.controllerOf(context).saveThemeToDisk();
          
          },
        ),
        SwitchListTile.adaptive(
          title: Text(
            'Notificaciones',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          activeColor: Theme.of(context).primaryColor,
          value: notification,
          onChanged: (value) {

            setState(() {
              notification = value;
            });
          
          },
        )
      ],
    );
  }
}
