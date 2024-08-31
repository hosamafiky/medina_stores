import 'dart:developer';

import 'package:pusher_client/pusher_client.dart';

class PusherClientHelper {
  late PusherClient _pusher;
  late Channel _channel;

  PusherClientHelper(String apiKey, String cluster) {
    _pusher = PusherClient(
      apiKey,
      PusherOptions(cluster: cluster, encrypted: true),
      autoConnect: false,
    );
  }

  void connect() {
    _pusher.connect();
    _pusher.onConnectionStateChange((state) {
      log("Connection state: ${state!.currentState}", name: "PusherClientHelper");
    });

    _pusher.onConnectionError((error) {
      log("Connection error: ${error!.message}", name: "PusherClientHelper");
    });
  }

  void subscribe(String channelName, String eventName, Function onEvent) {
    _channel = _pusher.subscribe(channelName);
    _channel.bind(eventName, (PusherEvent? event) {
      onEvent(event?.data);
    });
  }

  Future<void> unsubscribe(String channelName) async {
    return await _pusher.unsubscribe(channelName);
  }

  Future<dynamic> disconnect() async {
    return await _pusher.disconnect();
  }
}
