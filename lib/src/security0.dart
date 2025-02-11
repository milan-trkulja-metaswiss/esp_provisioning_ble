import 'package:esp_provisioning_ble/esp_provisioning_ble.dart';
import 'package:esp_provisioning_ble/src/protos/generated/sec0.pb.dart';
import 'package:esp_provisioning_ble/src/protos/generated/session.pb.dart';
import 'package:flutter/foundation.dart';

class Security0 implements ProvSecurity {
  final bool verbose;
  Security0State sessionState;

  Security0({
    this.verbose = false,
    this.sessionState = Security0State.step0Request,
  });

  void _verbose(dynamic data) {
    if (verbose) {
      if (kDebugMode) {
        print('+++ $data +++');
      }
    }
  }

  @override
  Future<Uint8List> encrypt(Uint8List data) async {
    return data;
  }

  @override
  Future<Uint8List> decrypt(Uint8List data) async {
    return data;
  }

  @override
  Future<SessionData?> securitySession(SessionData? responseData) async {
    SessionData? sessionData;
    switch (sessionState) {
      case Security0State.step0Request:
        sessionState = Security0State.step0Response;
        sessionData = getStep0Request();
        break;

      case Security0State.step0Response:
        processStep0Response(responseData);
        break;
    }
    return sessionData;
  }

  SessionData getStep0Request() {
    _verbose('step0Request');
    var setupRequest = SessionData();

    setupRequest.secVer = SecSchemeVersion.SecScheme0;

    S0SessionCmd sc0 = S0SessionCmd();
    Sec0Payload s0p = Sec0Payload();

    s0p.sc = sc0;
    setupRequest.sec0 = s0p;
    return setupRequest;
  }

  void processStep0Response(SessionData? responseData) {
    if (responseData == null) {
      throw Exception('No response from device');
    }
    if (responseData.secVer != SecSchemeVersion.SecScheme0) {
      throw Exception('Security version mismatch');
    }
    throw Exception('Unsupported security protocol');
  }
}
