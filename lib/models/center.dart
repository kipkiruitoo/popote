import 'package:huduma_popote/models/subservice.dart';

class CenterModel {
  String name;
  List<SubService> services;
  CenterModel({this.name, this.services});

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    var servicesFromJson = json["services"];
    List<SubService> innerservices = new List();
    for (var serv in servicesFromJson) {
      innerservices.add(new SubService(title: serv["title"] as String));
    }

    return new CenterModel(
        name: json["name"] as String, services: innerservices);
  }
}
