import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
          title: const Text('Профиль', style: TextStyle(color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //fix inkwell color and width
              TextButton.icon(
                onPressed: () {
                  // Respond to button press
                },
                icon: Icon(
                  Icons.person,
                  size: 18,
                  color: Colors.black,
                ),
                label: Text(
                  "Мои данные",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              TextButton.icon(
                onPressed: () {
                  // Respond to button press
                },
                icon: Icon(
                  Icons.book,
                  size: 18,
                  color: Colors.black,
                ),
                label: Text(
                  "Мои бронирования",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              TextButton.icon(
                onPressed: () {
                  // Respond to button press
                },
                icon: Icon(
                  Icons.bookmark,
                  size: 18,
                  color: Colors.black,
                ),
                label: Text(
                  "Избранное",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              TextButton.icon(
                onPressed: () {
                  // Respond to button press
                },
                icon: Icon(
                  Icons.notifications,
                  size: 18,
                  color: Colors.black,
                ),
                label: Text(
                  "Уведомления",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              SizedBox(height: 190),
              Container(
                //
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: 160,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Поддержка", style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text(
                          'Сообщите нам, если у вас возникли проблемы с сервисом.'),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                //add help message
                              },
                              icon: Icon(Icons.mail_outline, size: 35)),
                          SizedBox(width: 7),
                          IconButton(
                              onPressed: () {
                                //add help phone
                              },
                              icon: Icon(Icons.phone, size: 35)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
