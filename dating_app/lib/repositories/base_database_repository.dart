import 'package:dating_app/models/user.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser();
  Future<void> updateUserPictures(String imagePath);
}
