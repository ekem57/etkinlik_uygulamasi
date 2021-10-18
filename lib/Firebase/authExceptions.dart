class Hatalar {
  static String goster(String hatakodu) {
    switch (hatakodu) {
      case 'email-alreadyin-use':
        return "Bu email kullanımda.";
      case 'network-request-failed':
        return 'İnternet bağlantınız yok.';
      default:
        return 'Üzgünüm bir hata oluştu';
    }
  }
}
