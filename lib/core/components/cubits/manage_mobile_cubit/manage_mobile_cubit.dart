import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manage_mobile_state.dart';

class ManageMobileCubit extends Cubit<ManageMobileState> {
  ManageMobileCubit() : super(ManageMobileInitial());

  int currentPage = 0;
  void changeCurrentPage(int index) {
    emit(ManageMobileInitial());
    currentPage = index;
    emit(const ManageMobileChanged());
  }
}
