import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> ProjectFiltersBottomSheet(BuildContext context) {
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
  late FixedExtentScrollController scrollController;

  int kitchenValue = 0;
  final kitchenItems = [
    'Любая',
    'Русская',
    'Японская',
    'Грузинская'
  ]; //add kitchens
  late String kitchenName = kitchenItems[kitchenValue];

  showKitchenTypePicker() {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                SizedBox(
                    height: 180,
                    child: CupertinoPicker(
                        scrollController: scrollController,
                        backgroundColor: Colors.white,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            kitchenValue = value;
                            kitchenName = kitchenItems[value];
                          });
                        },
                        itemExtent: 64,
                        children: kitchenItems
                            .map((item) => Center(child: Text(item)))
                            .toList())),
              ],
              cancelButton: CupertinoActionSheetAction(
                  child: Text(
                    "Применить",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context)),
            ));
  }

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: kitchenValue);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Фильтры",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    Text("Кухня"),
                    SizedBox(height: 15),
                    Text("Средний чек"),
                    SizedBox(height: 15),
                    Text("Рейтинг"),
                    SizedBox(height: 15),
                    Text("Расстояние"),
                    SizedBox(height: 30),
                    Text(
                      "Показать сначала",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    Text("По расстоянию"),
                    SizedBox(height: 15),
                    Text("По рейтингу"),
                    SizedBox(height: 15),
                    Text("Недорогие"),
                    SizedBox(height: 15),
                    Text("Дорогие")
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory),
                        onPressed: () {
                          //сбросить
                          Navigator.pop(context);
                        },
                        child: const Text("Сбросить",
                            style: TextStyle(
                              height: -0.1,
                              color: Colors.black,
                              fontSize: 15,
                            ))),
                    TextButton(
                        onPressed: () {
                          scrollController.dispose();
                          scrollController = FixedExtentScrollController(
                              initialItem: kitchenValue);
                          showKitchenTypePicker();
                        },
                        child: Text(
                          kitchenName,
                          style: TextStyle(color: Colors.black),
                        )),

                    const SizedBox(height: 15),
                    const Text("r icons"),
                    const SizedBox(height: 15),
                    const Text("star icons"),
                    const SizedBox(height: 15),
                    const Text("slider"),
                    const SizedBox(height: 15),
                    // Container(
                    //     width: double.maxFinite,
                    //     child: CupertinoSlider(
                    //         min: 0.0,
                    //         max: 100.0,
                    //         value: 20,
                    //         onChanged: (value) {})),
                    const Text("icon"),
                    const SizedBox(height: 80),
                    const Text("-"),
                    const SizedBox(height: 15),
                    const Text("-"),
                    const SizedBox(height: 15),
                    const Text("-"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
