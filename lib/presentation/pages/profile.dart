import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/presentation/pages/bookings.dart';
import 'package:lit/presentation/pages/profile_data.dart';
import 'package:lit/presentation/pages/favorites.dart';
import 'package:lit/presentation/pages/notifications.dart';
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

  profileData(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
      onPressed: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const ProfileDataPage()));
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
    );
  }

  profileBooking(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
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
    );
  }

  profileFavorites(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
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
    );
  }

  profileNotifications(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
      onPressed: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => const ProfileNotificationsPage()));
      },
      icon: const Icon(
        Icons.notifications,
        size: 18,
        color: Colors.black,
      ),
      label: const Text(
        "Уведомления",
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                profileData(context),
                const SizedBox(height: 15),
                profileBooking(context),
                const SizedBox(height: 15),
                profileFavorites(context),
                const SizedBox(height: 15),
                // profileNotifications(context),
                // const SizedBox(height: 15),
                TextButton(
                  style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory),
                  onPressed: () async {
                    await storage.deleteAll();
                    Navigator.pushNamedAndRemoveUntil(
                        context, LOGIN, (r) => false);
                  },
                  child: Text("Выйти",
                      style: TextStyle(
                        color: Colors.red,
                      )),
                ),
                const SizedBox(height: 130), //?
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: profileSupport(context),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
