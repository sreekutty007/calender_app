import 'package:flutter/widgets.dart';

class EventDBModel {
  @required
  String? eventName;
  @required
  int? startDate;
  @required
  int? endDate;
  @required
  String? repeat;
  @required
  String? repeatValue;

  EventDBModel({this.eventName, this.startDate, this.endDate, this.repeat,this.repeatValue});

  EventDBModel.fromDb(Map<String, dynamic> map)
      : eventName = map['eventName'],
        startDate = map['startDate'],
        endDate = map['endDate'],
        repeat = map['repeat'],
        repeatValue = map['repeatValue'];

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['eventName'] = eventName;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['repeat'] = repeat;
    map['repeatValue'] = repeatValue;
    return map;
  }

  EventDBModel.random(
    String this.eventName,
    int this.startDate,
    int this.endDate,
    String this.repeat,
    String this.repeatValue
  );
}
