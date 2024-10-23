part of 'manage_mobile_cubit.dart';

sealed class ManageMobileState extends Equatable {
  const ManageMobileState();

  @override
  List<Object> get props => [];
}

final class ManageMobileInitial extends ManageMobileState {}

final class ManageMobileChanged extends ManageMobileState {


  const ManageMobileChanged();
}
