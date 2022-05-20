import 'package:flutter/material.dart';
import 'package:lit/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> supportMakePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> supportMail(String mail) async {
    final Uri launchUri =
        Uri(scheme: 'mailto', path: mail, queryParameters: {'subject': 'Lit'});
    await launchUrl(launchUri);
  }

  profileSupport(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width - 50,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Поддержка", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text(
                'Сообщите нам, если у вас возникли проблемы с сервисом.'),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      supportMail("igor.nik8888@gmail.com");
                    },
                    icon: const Icon(Icons.mail_outline, size: 35)),
                const SizedBox(width: 7),
                IconButton(
                    onPressed: () {
                      supportMakePhoneCall("89816809105");
                    },
                    icon: const Icon(Icons.phone, size: 35)),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
          title: const Text('Профиль', style: TextStyle(color: Colors.black)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, USER_DATA);
                      },
                      icon: const Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Мои данные",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton.icon(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, BOOKINGS);
                      },
                      icon: const Icon(
                        Icons.book,
                        size: 18,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Мои бронирования",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton.icon(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, FAVORITES);
                      },
                      icon: const Icon(
                        Icons.bookmark,
                        size: 18,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Избранное",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: profileSupport(context),
                ),
              ],
            ),
          ),
        ));
  }
}
