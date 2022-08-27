import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/register/register_cubit.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/presentation/widgets/app_elevated_button.dart';
import 'package:lit/presentation/widgets/app_text_field.dart';
import 'package:lit/presentation/widgets/select_city_widget.dart';
import 'package:lit/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:lit/presentation/widgets/snackbars/success_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final cities = ['Санкт-Петербург', 'Москва'];
  String city = 'Санкт-Петербург';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case UserRegistered:
            showTopSnackBar(
              context,
              const SuccessSnackbar(info: "Вы успешно зарегистрировались"),
            );
            Navigator.pushNamed(context, LOGIN);
            return;
          case RegisterError:
            if (!email.contains("@")) {
              showTopSnackBar(context,
                  const ErrorSnackbar(info: "Введите корректный email"));
              return;
            } else if (password.length < 5 || password.length > 25) {
              showTopSnackBar(
                  context,
                  const ErrorSnackbar(
                      info: "Введите пароль от 5 до 25 символов"));
              return;
            } else {
              showTopSnackBar(
                  context,
                  const ErrorSnackbar(
                      info: "Ошибка регистрации, попробуйте снова"));
              return;
            }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            toolbarHeight: 48,
            title: Text(
              "Регистрация",
              style: const TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(),
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
                    const SizedBox(height: 20),
                    SelectCityWidget(
                        onChanged: (newCity) {
                          setState(() => city = newCity!);
                        },
                        value: city),
                    const SizedBox(height: 20),
                    AppElevatedButton(
                        title: "Создать аккаунт",
                        fontSize: 18,
                        onPressed: () async {
                          context.read<RegisterCubit>().updateEmail(email);
                          context
                              .read<RegisterCubit>()
                              .updatePassword(password);
                          context.read<RegisterCubit>().updateCity(city);
                          BlocProvider.of<RegisterCubit>(context).registerUser(
                              context.read<RegisterCubit>().state.data);
                        },
                        width: MediaQuery.of(context).size.width)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
