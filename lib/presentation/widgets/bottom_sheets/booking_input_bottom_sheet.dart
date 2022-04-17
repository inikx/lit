import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/bloc/set_booking/set_booking_cubit.dart';
import 'package:lit/constants/locator.dart';
import 'package:lit/data/services/booking/repository.dart';
import 'package:lit/presentation/pages/booking_status.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<dynamic> BookingInputBottomSheet(BuildContext context, title) {
  if (getIt.isRegistered<SetBookingCubit>()) {
    getIt.unregister<SetBookingCubit>();
  }
  getIt.registerSingleton(
      SetBookingCubit(getIt<BookingRepository>(), getIt<BookingCubit>()));
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) => BlocProvider(
            create: (context) => getIt<SetBookingCubit>(),
            child: BottomSheet(title: title),
          ));
}

class BottomSheet extends StatefulWidget {
  String title;

  BottomSheet({Key? key, required this.title}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _commentEditingController = TextEditingController();
  int personCount = 1;
  //late FixedExtentScrollController scrollController;
  DateTime now = DateTime.now();
  DateTime? bookingDate;
  late DateFormat dateFormat;
  late DateFormat dateFormatDM;
  late DateFormat dateFormatT;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMMd('ru').add_jm();
    dateFormatDM = DateFormat.MMMMd('ru');
    dateFormatT = DateFormat.jm('ru');
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
        builder: (context) => BlocProvider(
            create: (context) => getIt<SetBookingCubit>(),
            child: CupertinoActionSheet(
                actions: [
                  SizedBox(
                      height: 180,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime(now.year, now.month, now.day,
                            now.hour, (now.minute < 30 ? 30 : 0)),
                        onDateTimeChanged: (value) {
                          setState(() {
                            bookingDate = value;
                          });
                        },
                        use24hFormat: true,
                        maximumDate: DateTime(now.year, now.month + 1, now.day,
                            now.hour, (now.minute < 30 ? 30 : 0)),
                        minimumDate: DateTime(now.year, now.month, now.day,
                            now.hour, (now.minute < 30 ? 30 : 0)),
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
                    onPressed: () => Navigator.pop(context)))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetBookingCubit, SetBookingState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SetingBookingSuccess:
              log("1");
              // showTopSnackBar(
              //   context,
              //   const SuccessSnackbar(info: "Задача успешно добавлена!"),
              // );
              return;
            case SetingBookingError:
              log("0");
              // showTopSnackBar(
              //   context,
              //   const ErrorSnackbar(info: "Не удалось добавить задачу"),
              // );
              return;
          }
        },
        child: FractionallySizedBox(
            heightFactor: 0.8, //keyboard on other devices?
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
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
                          children: <Widget>[
                            Text("Ваше имя"),
                            SizedBox(width: 150),
                            Flexible(
                                child: TextField(
                                    onChanged: (String value) async {
                                      context
                                          .read<SetBookingCubit>()
                                          .updateName(value);
                                    },
                                    controller: _nameEditingController,
                                    cursorColor: Colors.grey,
                                    textAlign: TextAlign.right,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
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
                                setState(() {
                                  if (personCount > 1) {
                                    personCount--;
                                    context
                                        .read<SetBookingCubit>()
                                        .updatePersonCount(personCount);
                                  }
                                });
                              },
                            ),
                          ),
                          Text(personCount.toString()),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    personCount++;
                                    context
                                        .read<SetBookingCubit>()
                                        .updatePersonCount(personCount);
                                  });
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
                                style: TextButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory),
                                onPressed: () {
                                  showDateTimePicker();
                                },
                                child: bookingDate != null
                                    ? Text(dateFormat.format(bookingDate!),
                                        style: TextStyle(color: Colors.black))
                                    : Text("Выберите дату и время",
                                        style: TextStyle(color: Colors.grey)))
                          ]),
                      const SizedBox(height: 15),
                      TextField(
                          onChanged: (String value) async {
                            context
                                .read<SetBookingCubit>()
                                .updateComment(value);
                          },
                          controller: _commentEditingController,
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
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: 180,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ))),
                          onPressed: () {
                            if (context
                                .read<SetBookingCubit>()
                                .state
                                .booking
                                .name
                                .isEmpty) {
                              return; //добавить проверку
                            } else {
                              context
                                  .read<SetBookingCubit>()
                                  .updateTitle(widget.title);
                              context
                                  .read<SetBookingCubit>()
                                  .updateTimeOfBooking(bookingDate);
                              log(context
                                  .read<SetBookingCubit>()
                                  .state
                                  .booking
                                  .toString());
                              BlocProvider.of<SetBookingCubit>(context)
                                  .setBooking(context
                                      .read<SetBookingCubit>()
                                      .state
                                      .booking);
                              Navigator.pop(context);
                            }

                            // Navigator.pop(context);
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => BookingStatusPage(
                            //             title: widget.title,
                            //             name: _nameEditingController.text,
                            //             date: dateFormatDM.format(bookingDate!),
                            //             time: dateFormatT.format(bookingDate!),
                            //             personCount: personCount,
                            //             comment:
                            //                 _commentEditingController.text)
                            //                 ));
                          },
                          child: const Text("Подтвердить",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
