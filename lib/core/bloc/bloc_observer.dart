import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/custom_print.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    CustomPrint.printBlocEvent(
        'Bloc Created ${bloc.runtimeType}'); // Purple for creation
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    CustomPrint.printBlocEvent(
        'Bloc Changed ${bloc.runtimeType}, $change'); // Cyan for changes
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    CustomPrint.printBlocEvent(
        'Bloc Error ${bloc.runtimeType}, $error'); // Red for errors
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    CustomPrint.printBlocEvent(
        'Bloc Closed ${bloc.runtimeType}'); // Yellow for closure
  }
}
