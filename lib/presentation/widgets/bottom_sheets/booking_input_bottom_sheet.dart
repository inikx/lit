import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit/presentation/pages/booking_status.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<dynamic> BookingInputBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return BottomSheet();
      });
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  //late FixedExtentScrollController scrollController;
  DateTime now = DateTime.now();
  DateTime? bookingDate;
  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMMd('ru').add_jm();
    //scrollController = FixedExtentScrollController(initialItem: kitchenValue);
  }

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  showDateTimePicker() {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
                actions: [
                  SizedBox(
                      height: 180,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime(now.year, now.month, now.day,
                            now.hour + 1, (now.minute % 30 * 30).toInt()),
                        onDateTimeChanged: (value) {
                          setState(() {
                            bookingDate = value;
                          });
                        },
                        use24hFormat: true,
                        maximumDate: DateTime(now.year, now.month + 1, now.day,
                            now.hour, (now.minute % 30 * 30).toInt()),
                        minimumDate: DateTime(now.year, now.month, now.day,
                            now.hour, (now.minute % 30 * 30).toInt()),
                        minuteInterval: 30,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        backgroundColor: Colors.white,
                      ))
                ],
                cancelButton: CupertinoActionSheetAction(
                    child: Text(
                      "Применить",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => print(DateTime.now()))
                //Navigator.pop(context)),
                ));
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.8, //keyboard on other devices?
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
              child: Column(
                children: [
                  Container(
                      height: 8,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)))),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text("Ваше имя"),
                        SizedBox(width: 150),
                        Flexible(
                            child: TextField(
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.right,
                                autofocus: true,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  hintText: 'Введите имя',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                  border: InputBorder.none,
                                ))),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Количество персон"),
                      const SizedBox(width: 100),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: FloatingActionButton(
                          child: const Icon(Icons.remove,
                              color: Colors.black, size: 15),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            // setState(() {
                            //   numberOfperson++;
                            // });
                          },
                        ),
                      ),
                      Text('0'), //add button work
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: FloatingActionButton(
                            onPressed: () {
                              // setState(() {
                              //   numberOfperson--;
                              // });
                            },
                            child: const Icon(Icons.add,
                                color: Colors.black, size: 15),
                            backgroundColor: Colors.white),
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Дата и время"),
                        TextButton(
                            onPressed: () {
                              showDateTimePicker();
                            },
                            child: bookingDate != null
                                ? Text(dateFormat.format(bookingDate!),
                                    style: TextStyle(color: Colors.black))
                                : Text("Выберите дату и время",
                                    style: TextStyle(
                                        color:
                                            Colors.grey))) //add showDatePicker
                      ]),
                  const SizedBox(height: 15),
                  TextField(
                      cursorColor: Colors.grey,
                      autofocus: false,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Комментарий',
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
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookingStatusPage(
                                  // TextFields -> BookingStatusPage Globalkey?
                                  title: "Пхали-Хинкали",
                                  date: "25 сентября",
                                  time: "19:00",
                                  personCount: "8",
                                  comment:
                                      "Можем задержаться на 20 минут"))); //fix bottomNavigation
                    },
                    child: const Text("Подтвердить",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
