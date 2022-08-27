import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lit/bloc/login/login_cubit.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/presentation/widgets/app_elevated_button.dart';
import 'package:lit/presentation/widgets/app_text_field.dart';
import 'package:lit/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:lit/presentation/widgets/snackbars/success_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInCubit, LogInState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case LoggedIn:
            showTopSnackBar(
              context,
              const SuccessSnackbar(info: "Вы успешно авторизовались"),
            );
            Navigator.pushNamedAndRemoveUntil(context, HOME, (r) => false);
            return;
          case LogInError:
            showTopSnackBar(context,
                const ErrorSnackbar(info: "Ошибка входа, попробуйте снова"));
            return;
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: SvgPicture.asset(
                    'assets/icons/lit_logo.svg',
                    semanticsLabel: 'Logo',
                    width: 100,
                  ),
                ),
                AppTextField(
                  obscureText: false,
                  enableSuggestions: true,
                  hintText: "Email",
                  onChanged: (String newEmail) {
                    setState(() => email = newEmail);
                  },
                ),
                const SizedBox(height: 30),
                AppTextField(
                  obscureText: true,
                  enableSuggestions: false,
                  hintText: "Пароль",
                  onChanged: ((String newPassword) {
                    setState(() => password = newPassword);
                  }),
                ),
                const SizedBox(height: 50),
                AppElevatedButton(
                  title: "Войти",
                  fontSize: 18,
                  width: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    context.read<LogInCubit>().updateEmail(email);
                    context.read<LogInCubit>().updatePassword(password);
                    BlocProvider.of<LogInCubit>(context)
                        .loginUser(context.read<LogInCubit>().state.data);
                  },
                ),
                const SizedBox(height: 7),
                TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: const Text(
                    "Создать аккаунт",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, REGISTER);
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
