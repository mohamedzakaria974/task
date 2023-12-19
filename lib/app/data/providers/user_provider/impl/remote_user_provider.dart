import '../../../exceptions/app_exception.dart';
import '../../../models/user/user.dart';
import '../../get_connect_http_client.dart';
import '../interface/iuser_repository.dart';

class RemoteUserProvider extends GetConnectHTTPClient
    implements IUserRepository {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      try {
        if (map is Map<String, dynamic>) {
          return User.fromJson(map);
        }
        if (map is List) {
          return map.map((item) => User.fromJson(item)).toList();
        }
      } catch (e) {
        throw AppException();
      }
    };
    httpClient.addRequestModifier<dynamic>((request) => updateHeaders(request));
    super.onInit();
  }

  @override
  Future<User?> getUser(int userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<User?> updateUserInformation(User newUser) {
    // TODO: implement updateUserInformation
    throw UnimplementedError();
  }
}
