import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/bloc/set_booking/set_booking_cubit.dart';
import 'package:lit/constants/locator.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/services/booking/repository.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lit/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:lit/presentation/widgets/snackbars/success_snackbar.dart';
import 'package:lit/route.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

Future<dynamic> BookingInputBottomSheet(BuildContext context, title, phone) {
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
            child: BottomSheet(
              title: title,
              phone: phone,
            ),
          ));
}

class BottomSheet extends StatefulWidget {
  String title;
  String phone;

  BottomSheet({Key? key, required this.title, required this.phone})
      : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _commentEditingController = TextEditingController();
  int personCount = 1;
  DateTime now = DateTime.now().toLocal();

  DateTime? bookingDate;
  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMMd('ru').add_jm();
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
                        initialDateTime: DateTime(
                            now.year,
                            now.month,
                            now.day,
                            (now.minute < 30 ? now.hour : now.hour + 1),
                            (now.minute < 30 ? 30 : 0)),
                        onDateTimeChanged: (value) {
                          setState(() {
                            bookingDate = value;
                          });
                        },
                        use24hFormat: true,
                        maximumDate: DateTime(now.year, now.month + 1, now.day,
                            now.hour, (now.minute < 30 ? 30 : 0)),
                        minimumDate: DateTime(
                            now.year,
                            now.month,
                            now.day,
                            (now.minute < 30 ? now.hour : now.hour + 1),
                            (now.minute < 30 ? 30 : 0)),
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
    if (getIt.isRegistered<SetBookingCubit>()) {
      getIt.unregister<SetBookingCubit>();
    }
    getIt.registerSingleton(
        SetBookingCubit(getIt<BookingRepository>(), getIt<BookingCubit>()));
    return BlocListener<SetBookingCubit, SetBookingState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SettingBookingSuccess:
              if (getIt.isRegistered<SetBookingCubit>()) {
                getIt.unregister<SetBookingCubit>();
              }
              getIt.registerSingleton(SetBookingCubit(
                  getIt<BookingRepository>(), getIt<BookingCubit>()));
              showTopSnackBar(
                context,
                const SuccessSnackbar(info: "Запрос на бронирование отправлен"),
              );
              Navigator.pushNamed(context, BOOKING_STATUS,
                  arguments: BookingStatusArguments(state.booking, false));
              return;
            case SettingBookingError:
              if (getIt.isRegistered<SetBookingCubit>()) {
                getIt.unregister<SetBookingCubit>();
              }
              getIt.registerSingleton(SetBookingCubit(
                  getIt<BookingRepository>(), getIt<BookingCubit>()));
              showTopSnackBar(
                context,
                const ErrorSnackbar(info: "Ошибка запроса на бронирование"),
              );
              return;
          }
        },
        child: FractionallySizedBox(
            heightFactor: 0.85,
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
                            Text("Ваше имя:"),
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
                          const Text("Количество персон:"),
                          Row(
                            children: [
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
                              const SizedBox(width: 10),
                              Text(personCount.toString()),
                              const SizedBox(width: 10),
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
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Дата и время:"),
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
                      const SizedBox(height: 20),
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
                            context
                                .read<SetBookingCubit>()
                                .updateTitle(widget.title);
                            context
                                .read<SetBookingCubit>()
                                .updatePhone(widget.phone);
                            context
                                .read<SetBookingCubit>()
                                .updateTimeOfBooking(bookingDate);
                            context
                                .read<SetBookingCubit>()
                                .updatePersonCount(personCount);
                            if ((context
                                    .read<SetBookingCubit>()
                                    .state
                                    .booking
                                    .name
                                    .isEmpty) ||
                                bookingDate == null) {
                              showTopSnackBar(
                                  context,
                                  const ErrorSnackbar(
                                      info: "Введите данные бронирования"));
                            } else {
                              BlocProvider.of<SetBookingCubit>(context)
                                  .setBooking(context
                                      .read<SetBookingCubit>()
                                      .state
                                      .booking);
                              Navigator.pop(context);
                            }
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
