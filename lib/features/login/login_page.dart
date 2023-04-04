import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_example/features/home/home_page.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            //bu blocBuilder sayesinde bolc da oluşan değişikliler hemen ekrana yansır 
            return const Text("Login");
          },
        ),
      ),
      body: Center(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            //gelen state ler eğen bir tetikleme gerektiriyorsa buradan yapılabilir
            //mesela gelen giriş yapıldı durumuysa yönlendirme yapılabilir
            if (state is LoginLogedIn) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoginFail) {
              //eğer hata durumu varsa onu gösteriyoruz
              return Center(
                child: Text(state.errorText),
              );
            }
            if (state is LoginLogedOut) {
              //çıkış yaptığı durum
              return const Center(
                child: Text("Çıkış yapıldı"),
              );
            }
            //sona kalan ise initial ve login durumunda bu kısım çalışır
            //ancak login olunca başka sayfaya yönleneceği için
            // sadece initial durumda çalışır
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Giriş Yap"),
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginEventLogin(
                        username: "kulanıcı-adı",
                        password: "şifre",
                        forError: false));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text("Hata gönder"),
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginEventLogin(
                          username: "kulanıcı-adı",
                          password: "şifre",
                          forError: true,
                        ));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
