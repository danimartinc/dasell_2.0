import 'commons.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

import 'const/pallete.dart';
import 'maps/blocs/blocs.dart';
import 'maps/services/traffic_service.dart';

//Screens
import 'screens/auth/auth_screen.dart';
import './screens/bottom_navigation.dart';

void main() async {
  await initApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(
            create: (context) =>
                MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
        BlocProvider(
            create: (context) => SearchBloc(trafficService: TrafficService())),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AdProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => new NotificationModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => new MoveMap(),
          ),
          ChangeNotifierProvider(
            create: (_) => new MenuProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => new TabMenuProvider(),
          ),
        ],
        child: ThemeProvider(
          saveThemesOnChange: true,
          themes: [
            AppTheme(
              id: 'light_theme',
              //ID único del Light Theme
              description: 'ThemeLight',
              data: ThemeData(
                fontFamily: 'Roboto',
                primarySwatch: Palette.kToDark,
                /* colorScheme: ColorScheme.fromSwatch().copyWith(
                  //Accent Color
                  secondary: Colors.red,
                ),*/
                accentColor: Colors.indigo.shade800,
                cardColor: Colors.grey[200],
                backgroundColor: Colors.indigo,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.indigo,
                  unselectedItemColor: Colors.indigo,
                ),
                scaffoldBackgroundColor: Colors.white,
                accentColorBrightness: Brightness.dark,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.indigo,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            AppTheme.dark(
              id: 'dark_theme',
            ).copyWith(
              id: 'dark_theme',
              data: ThemeData.dark().copyWith(
                appBarTheme: AppBarTheme(
                  color: Color(0xff2a2a2a),
                ),
                primaryColor: Color.fromARGB(255, 24, 128, 117),
                accentColor: Color.fromARGB(255, 24, 128, 117),
                /*colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: Color(0xff03dac6),
                ),*/
                cardColor: Color(0xff2a2a2a),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Color(0xff2a2a2a),
                  selectedItemColor: Color.fromARGB(255, 24, 128, 117),
                  unselectedItemColor: Color.fromARGB(255, 24, 128, 117),
                ),
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Color.fromARGB(255, 24, 128, 117),
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
          child: ThemeConsumer(
            child: Builder(
              builder: (themeContext) => MaterialApp(
                navigatorKey: locator<NavigatorService>().navigatorKey,
                onGenerateRoute: (routeSettings) {
                  trace("CREATING ROUTE!", routeSettings.name );
                  switch (routeSettings.name) {
                    case 'chat':
                      return MaterialPageRoute(
                        builder: (context) => UsersChatScreen(),
                      );
                      //case "product":
                     //return MaterialPageRoute(builder: (context) => AddProduct() );
                  default:
                    return MaterialPageRoute(builder: (context) => MyApp());
                  }
                },
                title: 'DaSell',
                theme: ThemeProvider.themeOf(themeContext).data,
                debugShowCheckedModeBanner: false,
                //typical android way
                // home: FirebaseAuth.instance.currentUser() == null
                //     ? AuthScreen()
                //     : ChatScreen(),

                //alternatinve way, here the screen will get changed as soon as
                //the authstate changes
                //you don't need to call navigator.of.pushnamed in auth screen as
                //this method will get called as soon as the authstate changes
                home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle().copyWith(
                        statusBarBrightness: Brightness.light,
                        statusBarColor:
                            ThemeProvider.themeOf(context).id == 'light_theme'
                                ? Colors.indigo.shade800
                                : Color(0xff2a2a2a),
                        statusBarIconBrightness: Brightness.light,
                        systemNavigationBarColor:
                            ThemeProvider.themeOf(context).id == 'light_theme'
                                ? Colors.black54
                                : Color(0xff2a2a2a),
                        systemNavigationBarDividerColor: Colors.indigo.shade100,
                        systemNavigationBarIconBrightness: Brightness.dark,
                      ),
                    );
                    return snapshot.hasData
                        ? BottomNavigationScreen()
                        : AuthScreen();
                  },
                ),
                routes: routes,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
