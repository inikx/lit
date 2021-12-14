import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Icon(
            Icons.free_breakfast,
            size: 150,
          ),
        ),
        Container(
          width: 300,
          child: TextField(
              keyboardType: TextInputType.number,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Номер телефона',
                hintStyle: TextStyle(
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
        SizedBox(height: 30),
        Container(
          width: 300,
          child: TextField(
              autofocus: false,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Пароль',
                hintStyle: TextStyle(
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
        SizedBox(height: 30),
        TextButton(
          child: Text(
            "Забыли пароль?",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          onPressed: () {
            // Respond to button press
          },
        ),
        SizedBox(height: 50),
        Container(
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: Text("Войти",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
        ),
        SizedBox(height: 7),
        TextButton(
          child: Text(
            "Регистрация",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          onPressed: () {
            // Respond to button press
          },
        ),
      ],
    );
  }
}
