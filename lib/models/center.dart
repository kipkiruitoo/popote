import 'package:huduma_popote/models/subservice.dart';

class CenterModel {
  String name;
  int id;
  String code;
  String openingTime;
  String closingTime;
  // List<SubService> services;
  CenterModel({this.name, this.id, this.code, this.closingTime, this.openingTime});

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    var servicesFromJson = json["services"];
    List<SubService> innerservices = new List();
    for (var serv in servicesFromJson) {
      innerservices.add(new SubService(title: serv["title"] as String));
    }

    return new CenterModel(name: json["name"] as String);
  }
}
