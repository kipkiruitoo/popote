import 'package:huduma_popote/models/subservice.dart';

class Service {
  // int id;
  String name;
  String image;
  List<SubService> services;

  Service({this.name, this.image, this.services});

  factory Service.fromJson(Map<String, dynamic> json) {
    var servicesFromJson = json["services"];
    List<SubService> innerservices = new List();
    for (var serv in servicesFromJson) {
      innerservices.add(new SubService(
          title: serv["service"] as String,
          description: serv["information"] as String,
          cost: serv["cost"] as String,
          timelines: serv["timelines"] as String,
          contact: serv["mda"]));
    }
    return new Service(
        name: json['title'] as String,
        image: json['icon'] as String,
        services: innerservices);
  }
}
