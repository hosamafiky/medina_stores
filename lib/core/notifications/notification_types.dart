part of 'notification_helper.dart';

enum NotificationType {
  info._(0, NotificationNavigatorInfo()),
  success._(1, NotificationNavigatorSuccess()),
  warning._(2, NotificationNavigatorWarning()),
  error._(3, NotificationNavigatorError()),
  none._(4, NotificationNavigatorNone());

  static NotificationType fromId(int id) {
    return values.firstWhere((element) => element.id == id, orElse: () => none);
  }

  final int id;
  final NotificationNavigator navigator;

  const NotificationType._(this.id, this.navigator);
}
