class MesajModel {
  final int id;
  final String odaId;
  final String gondericiUserId;
  final String aliciUserId;
  final DateTime tarih;
  final bool iletildi;
  final bool okundu;
  final String mesaj;

  MesajModel({this.id,
      this.mesaj,
      this.odaId,
      this.gondericiUserId,
      this.aliciUserId,
      this.tarih,
      this.iletildi,
      this.okundu});

  MesajModel.fromMap(Map<String, dynamic> map)
      : this.odaId = map["odaId"],
        this.gondericiUserId = map["gondericiUserId"],
        this.aliciUserId = map["aliciUserId"],
        this.tarih = map["tarih"],
        this.iletildi = map["iletildi"],
        this.okundu = map["okundu"],
        this.mesaj = map["mesaj"],
        this.id = map["id"];
}
