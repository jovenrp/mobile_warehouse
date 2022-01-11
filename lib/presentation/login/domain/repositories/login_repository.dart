abstract class LoginRepository {
  Future<String> login({required String username, required String password});
}
