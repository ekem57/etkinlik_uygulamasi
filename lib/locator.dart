import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/Firebase/authentication.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_auth_service.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/Firebase/user_repo.dart';
import 'package:get_it/get_it.dart';


final locator =GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationNewUser());
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => AdminFirebaseIslemleri());

}
