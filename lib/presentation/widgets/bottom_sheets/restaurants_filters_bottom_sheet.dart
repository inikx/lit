import 'package:flutter/material.dart';
import 'package:lit/data/providers/filters_provider.dart';
import 'package:lit/presentation/widgets/app_elevated_button.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

Future<dynamic> ProjectFiltersBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    builder: (_) {
      return BottomSheet();
    },
  );
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  final List<String> kitchenItems = [
    "азиатская",
    "вегетарианская",
    "грузинская",
    "европейская",
    "итальянская",
    "китайская",
    "русская",
    "японская",
    "авторская",
    "азербайджанская",
    "американская",
    "армянская",
    "бельгийская",
    "восточная",
    "вьетнамская",
    "греческая",
    "израильская",
    "индийская",
    "испанская",
    "кавказская",
    "корейская",
    //"латиноамериканская",
    "мексиканская",
    "немецкая",
    "сербская",
    "скандинавская",
    "смешанная",
    "средиземноморская",
    "стритфуд",
    "тайская",
    "узбекская",
    "украинская",
    "французская",
    "чешская",
  ];

  void showMultiSelectKitchen(BuildContext context) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (_) {
          return MultiSelectBottomSheet(
            items: kitchenItems
                .map((kitchen) => MultiSelectItem(kitchen, kitchen))
                .toList(),
            initialValue: context.watch<FiltersProvider>().selectedKitchens,
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) =>
                Provider.of<FiltersProvider>(context, listen: false)
                    .changeSelectedKitchens(values),
            initialChildSize: 0.4,
            maxChildSize: 0.95,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                "Кухни",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            cancelText: Text(
              "Отменить",
              style: TextStyle(color: Colors.black),
            ),
            confirmText: Text(
              "Применить",
              style: TextStyle(color: Colors.black),
            ),
            selectedColor: Colors.black,
            selectedItemsTextStyle: TextStyle(color: Colors.white),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.63,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
        child: Column(
          children: <Widget>[
            Container(
                height: 8,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(8)))),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Фильтры",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory),
                        onPressed: () {
                          Provider.of<FiltersProvider>(context, listen: false)
                              .changeSelectedKitchens([]);
                          Provider.of<FiltersProvider>(context, listen: false)
                              .changePrice(SfRangeValues(0.0, 3000.0));
                          Provider.of<FiltersProvider>(context, listen: false)
                              .changeRating(1.0);
                          Provider.of<FiltersProvider>(context, listen: false)
                              .changeSort('С наибольшим рейтингом');
                          Navigator.pop(context);
                        },
                        child: const Text("Сбросить",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ))),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Кухня"),
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory),
                            onPressed: () {
                              showMultiSelectKitchen(context);
                            },
                            child: Text(
                              context
                                      .watch<FiltersProvider>()
                                      .selectedKitchens
                                      .isEmpty
                                  ? "Любая"
                                  : context
                                      .watch<FiltersProvider>()
                                      .selectedKitchens
                                      .join(", "),
                              style: TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.right,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Средний чек"),
                    SfRangeSlider(
                      min: 0.0,
                      max: 3000.0,
                      values: context.watch<FiltersProvider>().price,
                      stepSize: 500,
                      interval: 1000,
                      showTicks: true,
                      showLabels: true,
                      labelFormatterCallback:
                          (dynamic actualValue, String formattedText) {
                        return actualValue == 3000 ? '∞' : '$formattedText';
                      },
                      enableTooltip: true,
                      tooltipTextFormatterCallback:
                          (dynamic actualValue, String formattedText) {
                        return actualValue == 3000 ? '∞' : '$formattedText';
                      },
                      startThumbIcon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 15,
                      ),
                      endThumbIcon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 15,
                      ),
                      minorTicksPerInterval: 1,
                      inactiveColor: Colors.grey[300],
                      activeColor: Colors.black,
                      onChanged: (SfRangeValues values) {
                        Provider.of<FiltersProvider>(context, listen: false)
                            .changePrice(values);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Рейтинг"),
                    SfSlider(
                      min: 1.0,
                      max: 10.0,
                      value: context.watch<FiltersProvider>().rating,
                      stepSize: 1,
                      interval: 1,
                      showTicks: true,
                      showLabels: true,
                      enableTooltip: true,
                      thumbIcon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 15,
                      ),
                      inactiveColor: Colors.grey[300],
                      activeColor: Colors.black,
                      onChanged: (dynamic value) {
                        Provider.of<FiltersProvider>(context, listen: false)
                            .changeRating(value);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Сортировать",
                    ),
                    DropdownButton<String>(
                      value: context.watch<FiltersProvider>().sort,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? value) {
                        Provider.of<FiltersProvider>(context, listen: false)
                            .changeSort(value);
                      },
                      items: <String>[
                        'С наибольшим рейтингом',
                        'Недорогие',
                        'Дорогие'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                              width: 180.0,
                              child: Text(value, textAlign: TextAlign.right)),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            AppElevatedButton(
                title: "Применить",
                onPressed: () {
                  Navigator.pop(context);
                },
                width: 200,
                fontSize: 18)
          ],
        ),
      ),
    );
  }
}
