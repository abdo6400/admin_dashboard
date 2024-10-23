
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../config/database/api/api_consumer.dart';
import '../config/intercepters/requests_interceptor.dart';
import '../config/database/api/dio_consumer.dart';
import '../config/database/cache/cache_consumer.dart';
import '../config/database/cache/secure_cache_helper.dart';
import '../config/database/network/netwok_info.dart';
import '../config/intercepters/route_intercepter.dart';
import '../core/bloc/bloc_observer.dart';
import '../core/components/cubits/auth_check_cubit/auth_check_cubit.dart';
import '/core/bloc/global_cubit/locale_cubit.dart';
import '/core/bloc/global_cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async { 
  await _authInit();
  await _app();
  // basics services //
  const sharedPreferences = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      wOptions: WindowsOptions(useBackwardCompatibility: true));
  sl.registerLazySingleton<RouteIntercepter>(() => RouteIntercepter());
  Bloc.observer = MyBlocObserver();
  sl.registerLazySingleton<CacheConsumer>(
      () => SecureCacheHelper(sharedPref: sharedPreferences));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<AuthCheckCubit>(() => AuthCheckCubit());
  sl.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(client: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true));
  sl.registerLazySingleton(() => RequestsIntercepter(
        client: sl(),
      ));
}

Future<void> _app() async {
  //! Blocs or cubits
 

  //! Use cases
 

  //! Repositories
  
  //! Data sources
  
}

Future<void> _authInit() async {
  //! Blocs or cubits
  //! Use cases
  //! repositories
}
