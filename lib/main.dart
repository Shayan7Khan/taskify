import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/routes/app_router.dart';
import 'package:taskify/firebase_options.dart';
import 'package:taskify/locator.dart';

final FlutterLocalNotificationsPlugin localNotifications =
    FlutterLocalNotificationsPlugin();

Future<void> initLocalNotifications() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'task_reminders',
    'Task Reminders',
    description: 'Reminders for your pending tasks',
    importance: Importance.max,
    playSound: true,
  );

  await localNotifications
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  const AndroidInitializationSettings android = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  const InitializationSettings settings = InitializationSettings(
    android: android,
  );

  await localNotifications.initialize(settings: settings);
}

Future<void> showNotification(RemoteMessage message) async {
  final String title = message.data['title'] ?? 'Task Reminder';
  final String body = message.data['body'] ?? 'You have a pending task!';

  print('Showing notification: $title - $body');

  final AndroidNotificationDetails android = AndroidNotificationDetails(
    'task_reminders',
    'Task Reminders',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    fullScreenIntent: true, // force it to show
    visibility: NotificationVisibility.public, // show on lock screen too
    playSound: true,
    enableVibration: true,
  );

  final NotificationDetails details = NotificationDetails(android: android);

  try {
    await localNotifications.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: details,
    );
    print('Notification shown successfully!');
  } catch (e) {
    print('Error showing notification: $e');
  }
}

@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize local notifications in background too
  await initLocalNotifications();

  print('Background message: ${message.notification?.title}');
  await showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessageHandler);

  await initLocalNotifications();
  // Explicitly request notification permission at runtime
  await localNotifications
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message received!');
    print('Data: ${message.data}'); // add this
    showNotification(message);
  });

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  await setupLocator();
  // TEMPORARY TEST - remove after testing
  Future.delayed(Duration(seconds: 3), () async {
    await localNotifications.show(
      id: 99,
      title: 'Test Notification',
      body: 'Direct local notification test!',
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders',
          'Task Reminders',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          visibility: NotificationVisibility.public,
        ),
      ),
    );
    print('Local notification fired!');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: MaterialApp.router(
        title: 'Taskify',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
