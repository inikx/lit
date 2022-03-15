import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit/presentation/pages/profile_bookings.dart';
import 'package:lit/presentation/pages/profile_data.dart';
import 'package:lit/presentation/pages/profile_favorites.dart';
import 'package:lit/presentation/pages/profile_notifications.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
        body: Padding(
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
              profileNotifications(context),
              const SizedBox(height: 190),
              Container(
                alignment: Alignment.center,
                child: profileSupport(context),
              ),
            ],
          ),
        ));
  }
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
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => const ProfileBookingsPage()));
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
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => const ProfileFavoritesPage()));
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
    //   decoration: BoxDecoration(
    //   color: Colors.white,
    //   border: Border.all(color: Colors.white),
    //   borderRadius: BorderRadius.circular(10.0),
    //   boxShadow: [
    //     BoxShadow(
    //       color: Colors.grey.withOpacity(0.4),
    //       spreadRadius: 1,
    //       blurRadius: 3,
    //       offset: Offset(0, 5),
    //     ),
    //   ],
    // ),
    width: MediaQuery.of(context).size.width - 50,
    height: 160,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Поддержка", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          const Text('Сообщите нам, если у вас возникли проблемы с сервисом.'),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    //add help message
                  },
                  icon: const Icon(Icons.mail_outline, size: 35)),
              const SizedBox(width: 7),
              IconButton(
                  onPressed: () {
                    //add help phone
                  },
                  icon: const Icon(Icons.phone, size: 35)),
            ],
          )
        ],
      ),
    ),
  );
}
