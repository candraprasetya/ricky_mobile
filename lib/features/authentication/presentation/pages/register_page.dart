import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ricky_mobile/features/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:ricky_mobile/utilities/utilities.dart';
import 'package:ricky_mobile/widgets/textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

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
            nameController.clear();
            phoneController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome ${state.user!.email}")));
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
                    Text('Buat akun baru',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    MyTextfield(
                        title: 'Nama Lengkap',
                        textEditingController: nameController),
                    const SizedBox(height: 8),
                    MyTextfield(
                        title: 'Email', textEditingController: emailController),
                    const SizedBox(height: 8),
                    MyTextfield(
                        title: 'Nomor Handphone',
                        textEditingController: phoneController),
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
                                : () {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(Register(
                                            email: emailController.text,
                                            fullName: nameController.text,
                                            password: passController.text,
                                            phoneNumber: phoneController.text));
                                  },
                            child: const Text(
                              'Buat Akun',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        context.go('/login');
                      },
                      child: Center(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Sudah punya akun?",
                              style: TextStyle(color: "B7B8B8".toColor())),
                          TextSpan(
                              text: " Login disini",
                              style: TextStyle(color: "0081CA".toColor()))
                        ])),
                      ),
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
