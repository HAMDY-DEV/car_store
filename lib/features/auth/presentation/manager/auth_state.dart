sealed class AuthState {}

final class AuthInitial extends AuthState {}

//Login States
final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginError extends AuthState {}

//Register States
final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterError extends AuthState {}

//Forgot Password States
final class ForgotPasswordLoading extends AuthState {}

final class ForgotPasswordSuccess extends AuthState {}

final class ForgotPasswordError extends AuthState {}

//Complete Registration
final class CompleteRegistrationLoading extends AuthState {}

final class CompleteRegistrationSuccess extends AuthState {}

final class CompleteRegistrationError extends AuthState {}

//Upload Photo
final class UploadPhotoLoading extends AuthState {}

final class UploadPhotoSuccess extends AuthState {}

final class UploadPhotoError extends AuthState {}