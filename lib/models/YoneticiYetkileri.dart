
class YoneticiYetkileri {

  String userid;
  bool moderator_atama;
  bool etkinlik_onay;
  bool mavi_tik;
  bool temsilci_atama;
  bool uye_islemleri;
  bool reklam_yetkisi;


  YoneticiYetkileri({

    this.userid,
    this.moderator_atama,
    this.etkinlik_onay,
    this.mavi_tik,
    this.temsilci_atama,
    this.uye_islemleri,
    this.reklam_yetkisi,
  });

  YoneticiYetkileri.fromMap(Map<String, dynamic> map)
      :
        userid = map['userId'],
        moderator_atama = map["moderator_atama"],
        etkinlik_onay = map["etkinlik_onay"],
        mavi_tik = map["mavi_tik"],
        temsilci_atama = map["temsilci_atama"],
        uye_islemleri = map["uye_islemleri"],
        reklam_yetkisi = map["reklam_yetkisi"];

}