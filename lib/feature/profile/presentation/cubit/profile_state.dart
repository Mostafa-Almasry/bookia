part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileSuccessState extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message);
}
