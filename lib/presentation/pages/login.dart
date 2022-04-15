import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lit/bloc/login/login_cubit.dart';
import 'package:lit/constants/strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInCubit, LogInState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case LoggedIn:
            //snackbar
            log("1");
            Navigator.pushNamedAndRemoveUntil(context, HOME, (r) => false);
            return;
          case LogInError:
            //snackbar
            log("0");
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        reverse: true,
        child: Center(
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
              Container(
                width: 300,
                child: TextField(
                    cursorColor: Colors.grey,
                    onChanged: (String value) async {
                      context.read<LogInCubit>().updateEmail(value);
                    },
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
                    onChanged: (String value) async {
                      context.read<LogInCubit>().updatePassword(value);
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
              const SizedBox(height: 50),
              Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ))),
                  onPressed: () async {
                    BlocProvider.of<LogInCubit>(context)
                        .loginUser(context.read<LogInCubit>().state.data);
                  },
                  child: const Text("Войти",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                ),
              ),
              const SizedBox(height: 7),
              TextButton(
                style:
                    TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
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
      )),
    );
  }
}
