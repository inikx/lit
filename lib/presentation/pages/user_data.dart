import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/user/user_cubit.dart';
import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/providers/filters_provider.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final cities = ['Санкт-Петербург', 'Москва'];

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).showUser();
    super.initState();
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
          title: const Text(
            "Мои данные",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            if (state is UserLoaded || state is UserCityUpdated) {
              var user = state.user;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email: ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: user.city,
                      onChanged: (newCity) async {
                        setState(() => user.city = newCity!);
                        context.read<UserCubit>().updateCity(user);
                        await storage.write(key: 'city', value: newCity);
                      },
                      items: cities
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      iconSize: 26,
                      underline: SizedBox(),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                      onPressed: () async {
                        await storage.deleteAll();
                        Provider.of<FiltersProvider>(context, listen: false)
                            .changeSelectedKitchens([]);
                        Provider.of<FiltersProvider>(context, listen: false)
                            .changePrice(SfRangeValues(0, 3000));
                        Provider.of<FiltersProvider>(context, listen: false)
                            .changeRating(1.0);
                        Provider.of<FiltersProvider>(context, listen: false)
                            .changeSort('С наибольшим рейтингом');
                        Navigator.pushNamedAndRemoveUntil(
                            context, LOGIN, (r) => false);
                      },
                      child: Text("Выйти",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ],
              );
            } else if (state is UserLoading) {
              return JumpingDotsProgressIndicator(
                dotSpacing: 8,
                fontSize: 80.0,
              );
            } else {
              return Center(child: Text("Ошибка загрузки данных"));
            }
          }),
        ));
  }
}
