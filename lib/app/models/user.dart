import 'package:vania/vania.dart';

class User extends Model {
  static final User _instance = User._internal();
  
  factory User() {
    return _instance;
  }

  User._internal() {
    super.table('users');
  }

  Future<void> logout() async {
    await clearToken();
  }

  Future<void> clearToken() async {
    // Implementasi penghapusan token
    // Misalnya menggunakan shared preferences atau penyimpanan lokal lainnya
  }
}
