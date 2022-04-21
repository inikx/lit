import 'package:flutter/material.dart';

class BookingWidget extends StatelessWidget {
  final String title;
  final String name;
  final String date;
  final String time;
  final int personCount;
  final String comment;

  const BookingWidget({
    Key? key,
    required this.title,
    required this.name,
    required this.personCount,
    required this.date,
    required this.time,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text("Название ресторана: "),
                        Expanded(
                          child: Text(title,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.visible)),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text("Имя гостя: "),
                      Text(name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Количество гостей: "),
                      Text(personCount.toString(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Дата: "),
                      Text(date,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Время: "),
                      Text(time,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Комментарий: "),
                      Expanded(
                        child: Text(comment != "" ? comment : "-",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.visible)),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }
}
