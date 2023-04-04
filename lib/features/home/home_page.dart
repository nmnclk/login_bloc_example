import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_example/features/login/bloc/login_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          //çıkış yapınca çalışacak kod
          if (state is LoginLogedOut) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(LoginEventLogOut());
              },
              child: const Text("Çıkış Yap"),
            ),
          );
        },
      ),
    );
  }
}
