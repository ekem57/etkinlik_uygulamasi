// To parse this JSON data, do
//
//     final ilVeIlce = ilVeIlceFromJson(jsonString);

import 'dart:convert';

IlVeIlce ilVeIlceFromJson(String str) => IlVeIlce.fromJson(json.decode(str));

String ilVeIlceToJson(IlVeIlce data) => json.encode(data.toJson());

class IlVeIlce {
  IlVeIlce({
    this.il,
    this.ilce,
  });

  List<Il> il;
  List<IlceElement> ilce;

  factory IlVeIlce.fromJson(Map<String, dynamic> json) => IlVeIlce(
    il: List<Il>.from(json["Il"].map((x) => Il.fromJson(x))),
    ilce: List<IlceElement>.from(json["Ilce"].map((x) => IlceElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Il": List<dynamic>.from(il.map((x) => x.toJson())),
    "Ilce": List<dynamic>.from(ilce.map((x) => x.toJson())),
  };

   List<String> ilVeilceListesi(){
    List<String> list = [];
    il.forEach((il) {
      list.add(il.il);
      var ilceler = ilce.where((ilce) => ilce.ilId == il.id );
      ilceler.forEach((element) {
        list.add(element.ilce);
      });
    });
    return list;
  }
}

class Il {
  Il({
    this.id,
    this.il,
  });

  String id;
  String il;

  factory Il.fromJson(Map<String, dynamic> json) => Il(
    id: json["Id"],
    il: json["Il"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Il": il,
  };
}

class IlceElement {
  IlceElement({
    this.id,
    this.ilce,
    this.ilId,
  });

  String id;
  String ilce;
  String ilId;

  factory IlceElement.fromJson(Map<String, dynamic> json) => IlceElement(
    id: json["Id"],
    ilce: json["Ilce"],
    ilId: json["Il_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Ilce": ilce,
    "Il_Id": ilId,
  };
}
