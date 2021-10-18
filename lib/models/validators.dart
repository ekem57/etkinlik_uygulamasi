class EmailValidator {
  static String validate(String value) {
    if(value.isEmpty){
      return "E-Posta boş olamaz";
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

    return emailValid ? null: "E-Posta geçerli değil";
  }
}

class PasswordValidator {
  static String validate(String value) {

    if(value.length < 6){
      return "Şifre en az 6 haneli olmalıdır!";
    }
    return value.isEmpty ? "Şifre boş olamaz" : null;

  }
}

class NameValidator{
  static String validate(String value) {
    return value.isEmpty ? "Ad Soyad boş olamaz" : null;
  }
}

class GeneralValidator{
  static String validate(String value) {
    return value.isEmpty ? "Bu alan boş olamaz" : null;
  }
}