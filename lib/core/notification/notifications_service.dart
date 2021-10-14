import 'dart:convert';

import 'package:ojos_app/core/res/global_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import '../appConfig.dart';
import '../constants.dart';

class NotificationsService {
  final notificationPlugin = new FlutterLocalNotificationsPlugin();
  int _currentId = 0;

  final selectNotificationSubject = BehaviorSubject<String>();

  void init(BuildContext context) {
    // Init Android.
    var android = new AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );

    // Init iOS.
    var ios = IOSInitializationSettings();

    // Init Notification Service.
    var initializationSettings =
        InitializationSettings(android: android, iOS: ios);

    notificationPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future showNotification(
    String title,
    String body,
    String payload,
  ) async {
    AndroidNotificationDetails android;
    android = AndroidNotificationDetails(
      NOTIFICATIONS_CHANNEL_ID,
      NOTIFICATIONS_CHANNEL_TITLE,
      NOTIFICATIONS_CHANNEL_DESCRIPTION,
      importance: Importance.max,
      priority: Priority.max,
      color: globalColor.primaryColor,
      visibility: NotificationVisibility.public,
      channelShowBadge: true,
      enableLights: true,
      autoCancel: false,
      enableVibration: true,
      icon: '@mipmap/launcher_icon',
      playSound: true,
    );

    var ios = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: android, iOS: ios);
    notificationPlugin.show(
      _currentId++,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void onNotificationPressed(BuildContext context, String payload) {
    final jsonPayload = jsonDecode(payload);
    final notificationType = int.tryParse(jsonPayload['type'] as String);
    print("jsonPayload jsonPayload $jsonPayload");
    print('notificationType is $notificationType');
    // switch (notificationType) {
    //   case REQUEST_ANSWER_NOTIFICATION_TYPE:
    //     // final ticketModel =
    //     // MyTicketModel?.fromJson(jsonDecode(jsonPayload['data']));
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (context) => MyRequestPage(),
    //       ),
    //     );
    //     break;
    //
    // }
  }

  Future onSelectNotification(String? payload) async {
    print(payload);
    selectNotificationSubject.add(payload ?? 'error');
  }

  void dispose() {
    selectNotificationSubject.close();
  }
}
