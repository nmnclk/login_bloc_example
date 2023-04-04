import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEventLogin>((event, emit) async {
      //Login tetiklenince buradaki kodlar çalışır
      login(event, emit);
    });
    on<LoginEventLogOut>((event, emit) async {
      //Logout tetiklenince buradaki kodlar çalışır
      logOut(event, emit);
    });
    on<LoginEventShowError>((event, emit) {
      //showError tetiklenince buradaki kodlar çalışır
      fail(event, emit);
    });
    on<LoginEventLoginSuccess>((event, emit) {
      //hayali api mizden gelen sonuç başarılı olduğu için tetiklendi
      loginSuccess(event, emit);
    });
    on<LoginEventLogOutSuccess>((event, emit) {
      //hayali api mizden gelen sonuç başarılı olduğu için tetiklendi
      logoutSuccess(event, emit);
    });
  }
  loginSuccess(LoginEventLoginSuccess event, Emitter<LoginState> emit) {
    //giriş yapıldığıı yayınlıyoruz
    emit(LoginLogedIn());
  }

  logoutSuccess(LoginEventLogOutSuccess event, Emitter<LoginState> emit) {
    //çıkış yapıldığıı yayınlıyoruz
    emit(LoginLogedOut());
  }

  login(LoginEventLogin event, Emitter<LoginState> emit) {
    //burada api den uzun süren bir login işlemini taklit ediyorum
    //yükleniyor durumuna geçirdim değer dönünce yeni event atacağım
    emit(LoginLoading());

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (event.forError) {
          //hata çıktığı senaryoyu simile ediyoruz
          add(LoginEventShowError());
        } else {
          //giriş yapıldı tetiklemesi yapıyoruz
          add(LoginEventLoginSuccess());
        }
      },
    );
  }

  logOut(LoginEventLogOut event, Emitter<LoginState> emit) {
    //burada api den uzun süren bir logout işlemini taklit ediyorum
    //yükleniyor durumuna geçirdim hayali api den dönüş olunya yine tetiklenecek
    emit(LoginLoading());
    Future.delayed(
      const Duration(seconds: 3),
      () {
        //çıkış yapıldı bilgisini yayıyoruz
        add(LoginEventLogOutSuccess());
      },
    );
  }

  fail(LoginEventShowError event, Emitter<LoginState> emit) {
    //burada api den uzun süren bir logout işlemini taklit ediyorum{
    //çıkış yapıldı bilgisini yayıyoruz
    //buradan istediğimiz mesajı yayınlayabiliyoruz.
    //farklı state leri özelleştirerek bir birinden farklı değerler yayabiliriz
    emit(const LoginFail(errorText: "gönderilen hata metni"));
  }
}
