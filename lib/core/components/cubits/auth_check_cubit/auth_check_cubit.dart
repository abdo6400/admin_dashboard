import 'package:bloc/bloc.dart';

import '../../../../app/service_locator.dart';
import '../../../../config/database/cache/cache_consumer.dart';
import '../../../utils/app_enums.dart';

class AuthCheckCubit extends Cubit<bool> {
  AuthCheckCubit() : super(false);

  Future<void> checkAuthentication() async {
    final token =
        await sl<CacheConsumer>().getData(key: MySharedKeys.apiToken.name);
    emit(token != null);
  }
}
