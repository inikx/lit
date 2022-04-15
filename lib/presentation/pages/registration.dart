import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/register/register_cubit.dart';
import 'package:lit/constants/strings.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case UserRegistered:
            //snackbar
            log("1");
            Navigator.pushNamed(context, LOGIN);
            return;
          case RegisterError:
            //snackbar
            log("0");
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
                  const SizedBox(height: 50),
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
