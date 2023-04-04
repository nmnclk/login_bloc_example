part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEventLogin extends LoginEvent {
  LoginEventLogin(
      {required this.forError, required this.username, required this.password});
  final String username;
  final String password;
  //Bu değişkeni true olunca sanki hata çıkmış senaryosu uygulamak için koydum
  final bool forError;
  @override
  List<Object> get props => [username, password, forError];
}

class LoginEventLogOut extends LoginEvent {}

class LoginEventLogOutSuccess extends LoginEvent {}

class LoginEventShowError extends LoginEvent {}

class LoginEventLoginSuccess extends LoginEvent {}
