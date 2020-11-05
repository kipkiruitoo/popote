import 'package:huduma_popote/models/subservice.dart';

class DepartmentService {
  String name, img, ministry;
  List<SubService> services;

  DepartmentService({this.name, this.img, this.ministry, this.services});

  factory DepartmentService.fromJson(Map<String, dynamic> json) {
    var servicesFromJson = json["services"];
    List<SubService> innerservices = new List();
    for (var serv in servicesFromJson) {
      innerservices.add(new SubService(title: serv["name"] as String));
      // description: serv["description"] as String,
      // requirements: serv["requirements"],
      // cost: serv["cost"] as String,
      // timelines: serv["timelines"] as String,
      // contact: serv["mda"]));
    }

    return new DepartmentService(
        name: json['name'] as String,
        img: json['icon'] as String,
        ministry: json["ministry"] as String,
        services: innerservices);
  }
}
