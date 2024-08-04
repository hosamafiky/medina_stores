part of 'notification_helper.dart';

enum NotificationType {
  info._(1, NotificationNavigatorInfo()),
  success._(2, NotificationNavigatorSuccess()),
  warning._(3, NotificationNavigatorWarning()),
  error._(4, NotificationNavigatorError()),
  none._(0, NotificationNavigatorNone());

  static NotificationType fromId(int id) {
    return values.firstWhere((element) => element.id == id, orElse: () => none);
  }

  final int id;
  final NotificationNavigator navigator;

  const NotificationType._(this.id, this.navigator);
}
