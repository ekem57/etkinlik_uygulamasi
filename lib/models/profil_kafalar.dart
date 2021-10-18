
class Profil_kafalar {
  final String icon;
  final String name;
  int sayi;


  Profil_kafalar(
      {
        this.name,
        this.icon,
        this.sayi
      });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'sayi': sayi,

    };
  }

  Profil_kafalar.fromMap(Map<String, dynamic> map)
      : icon = map['icon'],
        name = map['name'],
        sayi = map['sayi'];

  @override
  String toString() {
    return 'Kafalar Profil{icon: $icon, name: $name, sayi: $sayi}';
  }
}
