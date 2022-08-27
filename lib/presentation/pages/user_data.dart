import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/user/user_cubit.dart';
import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/providers/filters_provider.dart';
import 'package:lit/presentation/widgets/app_elevated_button.dart';
import 'package:lit/presentation/widgets/select_city_widget.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Center(
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
                    SelectCityWidget(
                        onChanged: (newCity) async {
                          setState(() => user.city = newCity!);
                          context.read<UserCubit>().updateCity(user);
                          await storage.write(key: 'city', value: newCity);
                        },
                        value: user.city),
                    SizedBox(height: 50),
                    AppElevatedButton(
                        title: "Выйти",
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
                        width: MediaQuery.of(context).size.width,
                        fontSize: 18),
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
          ),
        ));
  }
}
