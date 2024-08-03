sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  Map<String, dynamic> data ;
  ProfileSuccess({required this.data});
}

final class ProfileError extends ProfileState {}
