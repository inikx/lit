import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/register/register_cubit.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:lit/presentation/widgets/snackbars/success_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var _controller = TextEditingController();
  final cities = ['Санкт-Петербург', 'Москва'];
  String city = 'Санкт-Петербург';

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case UserRegistered:
            showTopSnackBar(
              context,
              const SuccessSnackbar(info: "Вы успешно зарегистрировались!"),
            );
            Navigator.pushNamed(context, LOGIN);
            return;
          case RegisterError:
            showTopSnackBar(
                context,
                const ErrorSnackbar(
                    info: "Ошибка регистрации, попробуйте снова"));
            return;
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
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(),
                  Container(
                    width: 300,
                    child: TextField(
                        cursorColor: Colors.grey,
                        onChanged: (String value) {
                          context.read<RegisterCubit>().updateEmail(value);
                        },
                        //keyboardType: TextInputType.number,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        )),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 300,
                    child: TextField(
                        cursorColor: Colors.grey,
                        onChanged: (String value) {
                          context.read<RegisterCubit>().updatePassword(value);
                        },
                        autofocus: false,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Пароль',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        )),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: city,
                      onChanged: (newCity) {
                        setState(() => city = newCity!);
                      },
                      items: cities
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      iconSize: 26,
                      underline: SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Container(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                      onPressed: () async {
                        context.read<RegisterCubit>().updateCity(city);
                        BlocProvider.of<RegisterCubit>(context).registerUser(
                            context.read<RegisterCubit>().state.data);
                      },
                      child: const Text("Создать аккаунт",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
