import 'package:call_log/call_log.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallLogs {
  void call(String text) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(text);
  }

  getAvatar(CallType callType) {
    switch (callType) {
      case CallType.outgoing:
        return CircleAvatar(
            maxRadius: 30,
            foregroundColor: Colors.black,
            backgroundImage: AssetImage("assets/images/avatar_recents.png"));

      case CallType.missed:
        return CircleAvatar(
            maxRadius: 30,
            foregroundColor: Colors.red,
            backgroundImage: AssetImage("assets/images/avatar_recents.png"));
      default:
        return CircleAvatar(
            maxRadius: 30,
            foregroundColor: Colors.indigo,
            backgroundImage: AssetImage("assets/images/avatar_recents.png"));
    }
  }

  Future<Iterable<CallLogEntry>> getCallLogs() {
    return CallLog.get();
  }

  String formatDate(DateTime dt) {
    return DateFormat('d-MM-y H:m:s').format(dt);
  }

  getTitle(CallLogEntry entry) {
    if (entry.name == null) return Text(entry.number!);
    if (entry.name!.isEmpty)
      return Text(entry.number!);
    else
      return Text(entry.name!);
  }

  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
    String formatedDuration = "";
    if (d1.inHours > 0) {
      formatedDuration += d1.inHours.toString() + "h ";
    }
    if (d1.inMinutes > 0) {
      formatedDuration += d1.inMinutes.toString() + "m ";
    }
    if (d1.inSeconds > 0) {
      formatedDuration += d1.inSeconds.toString() + "s";
    }
    if (formatedDuration.isEmpty) return "0s";
    return formatedDuration;
  }
}
