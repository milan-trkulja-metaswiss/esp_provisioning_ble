part of 'ble_wifi_bloc.dart';

@immutable
abstract class BleWifiState {}

class BleWifiInitial extends BleWifiState {}

class BleWifiEstablishedConnectionState extends BleWifiState {}

class BleWifiEstablishedConnectionFailedState extends BleWifiState {}

class BleWifiScanningNetworksState extends BleWifiState {}

class BleWifiScannedNetworksState extends BleWifiState {}

class BleWifiEmptyListNewtworksState extends BleWifiState {}

class BleWifiSendedConfigState extends BleWifiState {}