import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/authentication/authentication_cubit.dart';
import 'package:lit/constants/strings.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case AuthenticationSuccess:
            Navigator.pushNamedAndRemoveUntil(context, HOME, (r) => false);
            return;
          case AuthenticationFailed:
            Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
            return;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    if (state is AuthenticationChecking) {
                      log(state.runtimeType.toString());
                      return Column(
                        children: const [
                          Text(
                            'Lit',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CircularProgressIndicator()
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
