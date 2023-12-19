import '../../../models/user/user.dart';

abstract class IUserRepository {
  Future<User?> getUser(int userId) {
    throw UnimplementedError();
  }

  Future<User?> updateUserInformation(User newUser) {
    throw UnimplementedError();
  }
}
