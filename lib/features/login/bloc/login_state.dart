part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState({this.isLoged = false});
  final bool isLoged;
  @override
  List<Object> get props => [isLoged];
}

class LoginInitial extends LoginState {}

class LoginLogedIn extends LoginState {}
class LoginLogedOut extends LoginState {}

class LoginFail extends LoginState {
  const LoginFail({required this.errorText});
  final String errorText;
  @override
  List<Object> get props => [isLoged,errorText];
}
class LoginLoading extends LoginState{}