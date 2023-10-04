part of 'ble_wifi_bloc.dart';

@immutable
abstract class BleWifiEvent {}

class BleWifiInitialEvent extends BleWifiEvent {
  final Peripheral peripheral;
  final String? pop;
  BleWifiInitialEvent({
    required this.peripheral,
    this.pop = 'abcd1234',
  });
}

class BleWifiEstablishedConnectionEvent extends BleWifiEvent {}

class BleWifiScanWifiNetworksEvent extends BleWifiEvent {}

class BleWifiLoadingEvent extends BleWifiEvent {}

class BleWifiGetStatusEvent extends BleWifiEvent {}

class BleWifiSendConfigEvent extends BleWifiEvent {
  final String ssid;
  final String password;
  final String customSendMessage;
  BleWifiSendConfigEvent({
    required this.ssid,
    required this.password,
    required this.customSendMessage,
  });
}
