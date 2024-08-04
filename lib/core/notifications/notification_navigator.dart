part of 'notification_helper.dart';

abstract class NotificationNavigator {
  const NotificationNavigator();

  Future<void> go({required Map<String, dynamic> data});
}

class NotificationNavigatorInfo extends NotificationNavigator {
  const NotificationNavigatorInfo();

  @override
  Future<void> go({required Map<String, dynamic> data}) async {
    log('Info notification: $data');
  }
}

class NotificationNavigatorSuccess extends NotificationNavigator {
  const NotificationNavigatorSuccess();

  @override
  Future<void> go({required Map<String, dynamic> data}) async {
    log('Success notification: $data');
  }
}

class NotificationNavigatorWarning extends NotificationNavigator {
  const NotificationNavigatorWarning();

  @override
  Future<void> go({required Map<String, dynamic> data}) async {
    log('Warning notification: $data');
  }
}

class NotificationNavigatorError extends NotificationNavigator {
  const NotificationNavigatorError();

  @override
  Future<void> go({required Map<String, dynamic> data}) async {
    log('Error notification: $data');
  }
}

class NotificationNavigatorNone extends NotificationNavigator {
  const NotificationNavigatorNone();

  @override
  Future<void> go({required Map<String, dynamic> data}) async => {};
}
