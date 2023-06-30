import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ricky_mobile/features/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:ricky_mobile/utilities/utilities.dart';
import 'package:ricky_mobile/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationIsFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
          if (state is AuthenticationIsSuccess) {
            emailController.clear();
            passController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome ${state.data!.fullName!}")));
            context.go('/home');
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 120,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Masuk',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    MyTextfield(
                        title: 'Email', textEditingController: emailController),
                    const SizedBox(height: 8),
                    MyTextfield(
                        title: 'Password',
                        textEditingController: passController),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: '171717'.toColor(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: (state is AuthenticationIsLoading)
                                ? null
                                : () async {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(Login(
                                            email: emailController.text,
                                            password: passController.text));
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(GetUserData());
                                  },
                            child: const Text(
                              'Masuk',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Sudah punya akun?",
                            style: TextStyle(color: "B7B8B8".toColor())),
                        TextSpan(
                            text: " Login disini",
                            style: TextStyle(color: "0081CA".toColor()))
                      ])),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
