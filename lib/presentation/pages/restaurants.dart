import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:lit_app/presentation/widgets/restaurants_list.dart';

class Restaurants extends StatelessWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const Pad(top: 50),
        child: Column(children: [
          const Padding(
            padding: Pad(all: 10),
            child: Text("ADDRESS"),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("uh blya"),
                        content: Text("zaebala eta ebatoriya"),
                      );
                    });
              },
              child: Container(
                  padding: const Pad(all: 10),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 1, color: Colors.grey),
                    bottom: BorderSide(width: 1, color: Colors.grey),
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  )),
                  child: const Center(child: Text("Sort"))),
            ),
            Container(
                padding: const Pad(all: 10),
                width: MediaQuery.of(context).size.width / 2,
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                  bottom: BorderSide(width: 1, color: Colors.grey),
                  left: BorderSide(width: 0.5, color: Colors.grey),
                )),
                child: const Center(child: Text("Sort"))),
          ]),
          SizedBox(
              height: MediaQuery.of(context).size.height - 189,
              child: RestaurantsList()),
        ]));
  }
}
