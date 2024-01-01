import 'package:dating_app/models/user.dart';

abstract class BaseUsersRepo {
  Stream<List<User>> getUsers();
}
