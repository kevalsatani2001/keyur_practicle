import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/api_client.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data_impl/repositories/auth_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Core
  sl.registerLazySingleton(() => ApiClient(sl<Dio>()));

  // Data sources
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl<ApiClient>()));

  // Repositories
  sl.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(sl<AuthRemoteDataSource>()));
}
