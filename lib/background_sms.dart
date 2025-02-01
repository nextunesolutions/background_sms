import 'dart:async';

import 'package:flutter/services.dart';

enum SmsStatus { sent, failed }

/// Represents a SIM card's information
class SimCard {
  /// The unique identifier for this subscription
  final int subscriptionId;

  /// The display name of the SIM (e.g., "SIM 1")
  final String displayName;

  /// The carrier name (e.g., "Verizon")
  final String carrierName;

  /// The physical slot index of the SIM card
  final int slotIndex;

  /// The phone number associated with this SIM card
  final String number;

  SimCard({
    required this.subscriptionId,
    required this.displayName,
    required this.carrierName,
    required this.slotIndex,
    required this.number,
  });

  factory SimCard.fromMap(Map<dynamic, dynamic> map) {
    return SimCard(
      subscriptionId: map['subscriptionId'] as int,
      displayName: map['displayName'] as String,
      carrierName: map['carrierName'] as String,
      slotIndex: map['slotIndex'] as int,
      number: map['number'] as String,
    );
  }
}

class BackgroundSms {
  static const MethodChannel _channel = const MethodChannel('background_sms');

  static Future<SmsStatus> sendMessage(
      {required String phoneNumber,
      required String message,
      int? simSlot}) async {
    try {
      String? result = await _channel.invokeMethod('sendSms', <String, dynamic>{
        "phone": phoneNumber,
        "msg": message,
        "simSlot": simSlot
      });
      return result == "Sent" ? SmsStatus.sent : SmsStatus.failed;
    } on PlatformException catch (e) {
      print(e.toString());
      return SmsStatus.failed;
    }
  }

  static Future<bool?> get isSupportCustomSim async {
    try {
      return await _channel.invokeMethod('isSupportMultiSim');
    } on PlatformException catch (e) {
      print(e.toString());
      return true;
    }
  }

  /// Gets information about all available SIM cards on the device
  ///
  /// Returns a list of [SimCard] objects containing information about each SIM card.
  /// Returns an empty list if no SIM cards are available or if there's an error.
  static Future<List<SimCard>> getSimCards() async {
    try {
      final List<dynamic> result =
          await _channel.invokeMethod('getSimCardsInfo');
      return result
          .map((dynamic item) => SimCard.fromMap(item as Map<dynamic, dynamic>))
          .toList();
    } on PlatformException catch (e) {
      print('Error getting SIM cards info: ${e.toString()}');
      return [];
    }
  }
}
