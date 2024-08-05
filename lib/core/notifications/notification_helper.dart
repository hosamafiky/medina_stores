import 'dart:async';
import 'dart:convert';
import "dart:developer";
import 'dart:io';

import "package:firebase_core/firebase_core.dart";
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'notification_navigator.dart';
part 'notification_types.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('========= >>> backGroundMessage ${message.data}');
}

class NotificationHelper {
  NotificationHelper._({
    required this.onRoutingMessage,
    required this.onNoInitialMessage,
  });

  final Function(RemoteMessage message) onRoutingMessage;
  final Function() onNoInitialMessage;

  static NotificationHelper? instance;
  factory NotificationHelper({
    required void Function(RemoteMessage message) onRoutingMessage,
    required void Function() onNoInitialMessage,
  }) {
    return instance ??= NotificationHelper._(
      onRoutingMessage: onRoutingMessage,
      onNoInitialMessage: onNoInitialMessage,
    );
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _androidNotificationChannel = AndroidNotificationChannel(
    'com.example.medina_stores',
    'High Importance Notifications',
    importance: Importance.high,
  );

  static String messagingToken = "";

  Future<bool> _requestPermissions() async {
    bool? result;
    if (Platform.isIOS) {
      result = await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      result = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      await _createAndroidChannel();
    }
    return result ?? false;
  }

  Future<void> _createAndroidChannel() async {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);
  }

  void _showNotification(RemoteMessage message) async {
    try {
      const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _androidNotificationChannel.id,
        _androidNotificationChannel.name,
        channelDescription: _androidNotificationChannel.description,
        enableVibration: true,
        playSound: true,
        icon: "@drawable/ic_stat_name",
        importance: Importance.high,
        priority: Priority.max,
      );
      final notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      final notification = message.notification;
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title ?? 'Medina Stores',
        notification?.body,
        notificationDetails,
        payload: json.encode(message.toMap()),
      );
    } catch (e) {
      log("Error showing notification: $e");
    }
  }

  Future<void> _initLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@drawable/ic_stat_name");

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse? response) {
      if (response?.payload != null) {
        _handleNotificationsTap(
          RemoteMessage.fromMap(
            json.decode(response?.payload ?? "{}"),
          ),
        );
      }
    });
  }

  Future<void> _registerNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _handleNotificationsTap(RemoteMessage? message) async {
    if (message == null) return;
    onRoutingMessage(message);
  }

  Future<void> _saveFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    messagingToken = token ?? "";
    log("Firebase Fcm token : ${token.toString()}");
  }

  Future<void> _setForegroundNotificationOptions() async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> setupNotifications() async {
    await Future.wait([
      _saveFcmToken(),
      _setForegroundNotificationOptions(),
      _registerNotification(),
      _requestPermissions(),
      checkForInitialMessage(),
    ]);
    await _initLocalNotification();
    _configureNotification();
  }

  void _configureNotification() async {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log("onMessage: ${event.toMap()}", name: "FirebaseMessaging");
      _showNotification(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      _handleNotificationsTap(event);
    });
  }

  RemoteMessage? _initialMessage;
  Future<void> checkForInitialMessage() async {
    _initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (_initialMessage != null) {
      onRoutingMessage(_initialMessage!);
    } else {
      onNoInitialMessage();
    }
  }
}