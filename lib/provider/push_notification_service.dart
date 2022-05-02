// import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import '../services/services.dart';

// // SHA1: 33:E2:CC:3B:84:7C:A4:7C:2C:CC:7D:4F:96:A8:A8:52:80:CB:1D:1C
// // P8 - KeyID: VYZH37GGZ9

// //Servicio para controlar las notificaciones de la aplicación
// class PushNotificationService {
//   //Obtenemos la instancia de FirebaseMessaging
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;

//   //Token del dispositivo que se genera
//   static String? token;

//   //Mediante un StreamController, podemos emitir un valor para poder escuchar desde el método initState() del main
//   //En el StreamController fluye información de tipo String
//   //Mediante broadcast() emitimos a todos los Widget que esten escuchando el Stream y puedan suscribirse
//   static StreamController<String> _messageStream = new StreamController.broadcast();

//   //Getter para obtener la información del Stream que retorna un stream
//   static Stream<String> get messagesStream => _messageStream.stream;

//   //Handlers, los cuales se llaman desde los distintos estados de la aplicación
//   //Método asíncrono que retorna un Future
//   static Future _backgroundHandler(RemoteMessage message) async {
//     //Mostramos el ID del mensaje
//     print('onBackground Handler ${message.messageId}');
//     print(message.data);
//     //Añadimos información al flujo del messagesStream a la notificación
//     //_messageStream.add( message.data['product'] ?? 'No data' );
//     /// TODO: encontra una forma de navegar a chat sin romper la app.
//     locator<NavigatorService>().navigateTo('/users_chat_screen');
//     _messageStream.add( message.notification!.title ?? 'No title' );
//   }

//   //Método
//   static Future _onMessageHandler(RemoteMessage message) async {
//     print('onMessage Handler ${message.messageId}');
//     print(message.data);
//     print(message.notification);
//     _messageStream.add(message.data['product'] ?? 'No data');
//     /// TODO: encontra una forma de navegar a chat sin romper la app.
//     locator<NavigatorService>().navigateTo('chat');

//     _messageStream.add( message.notification!.title ?? 'No title' );
//   }

//   static Future _onMessageOpenApp(RemoteMessage message) async {
//     print('onMessageOpenApp Handler ${message.messageId}');
//     print(message.data);
//     /// TODO: encontra una forma de navegar a chat sin romper la app.
//     locator<NavigatorService>().navigateTo('/users_chat_screen');

//     _messageStream.add(message.data['product'] ?? 'No data');
//     //_messageStream.add( message.notification!.title ?? 'No title' );
//   }

//   //Método estático para inicializar y configurar la instancia que retorna un Future
//   static Future initializeApp() async {
//     //Push Notifications
//     //Generamos el Token del dispositivo, devolviendo la propia aplicación de Firebase
//     await Firebase.initializeApp();
//     //await requestPermission();

//     //Almacenamos el Token del dispositivo, el cual obtenemos desde la instancia de FirebaseMessaging
//     token = await FirebaseMessaging.instance.getToken();

//     print('Token: $token');

//     //Inicialización de los Handlers
//     //Handler, cuando la aplicación está en el background en segundo plano
//     //Envio en el callback el _backgroundHandler
//     FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
//     //Handler, cuando la aplicación está abierta.
//     //Se implementa un listen(), que emite los cambios de tipo StreamSubscription<RemoteMessage>
//     FirebaseMessaging.onMessage.listen(_onMessageHandler);
//     //Handler, cuando la aplicación está en
//     FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

//     // Local Notifications
//   }

//   // Apple / Web
//   /*static requestPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true
//     );

//     print('User push notification status ${ settings.authorizationStatus }');

//   }
// */
//   //Cerramos el StreamController
//   static closeStreams() {
//     _messageStream.close();
//   }
// }
