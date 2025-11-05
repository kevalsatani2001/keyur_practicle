import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/models/login_response.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<LoginResponse> login({required String email, required String password}) {
    return remote.login(email: email, password: password);
  }
}
