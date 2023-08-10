import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_ble_lib_ios_15/flutter_ble_lib.dart';

import 'transport.dart';

class TransportBLE implements ProvTransport {
  final Peripheral peripheral;
  final String serviceUUID;
  late final Map<String, String> nuLookup;
  final Map<String, String> lockupTable;

  static const PROV_BLE_SERVICE = '021a9004-0382-4aea-bff4-6b3f1c5adfb4';
  static const PROV_BLE_EP = {
    'prov-scan': 'ff50',
    'prov-session': 'ff51',
    'prov-config': 'ff52',
    'proto-ver': 'ff53',
    'custom-data': 'ff54',
  };

  TransportBLE(this.peripheral,
      {this.serviceUUID = PROV_BLE_SERVICE, this.lockupTable = PROV_BLE_EP}) {
    nuLookup = {
      for (var name in lockupTable.keys) 
      name:  serviceUUID.substring(0, 4) +
            int.parse(lockupTable[name]!, radix: 16)
                .toRadixString(16)
                .padLeft(4, '0') +
            serviceUUID.substring(8)

    };
  }

  @override
  Future<bool> connect() async {
    bool isConnected = await peripheral.isConnected();
    if (isConnected) {
      return Future.value(true);
    }
    await peripheral.connect(requestMtu: 512);
    await peripheral.discoverAllServicesAndCharacteristics(
        transactionId: 'discoverAllServicesAndCharacteristics');
    return await peripheral.isConnected();
  }

  @override
  Future<Uint8List> sendReceive(String? epName, Uint8List? data) async {
    if (data != null){ 
      if( data.isNotEmpty){
        await peripheral.writeCharacteristic(serviceUUID, nuLookup[ epName ?? ""]!, data, true);
      }
    }
    CharacteristicWithValue receivedData = await peripheral.readCharacteristic(
        serviceUUID, nuLookup[ epName ?? ""]!,
        transactionId: 'readCharacteristic');
    return receivedData.value;
  }

  @override
  Future<bool> disconnect() async {
    bool check = await peripheral.isConnected();
    if(check){  
      await peripheral.disconnectOrCancelConnection();
      return true;
    }else{
      return false;
    }
  }

  @override
  Future<bool> checkConnect() async {
    return await peripheral.isConnected();
  }

  void dispose() {
    print('dispose ble');
  }
}
