import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:lit/presentation/pages/restaurant_page.dart';

class RestaurantsList extends StatelessWidget {
  const RestaurantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SingleChildScrollView(
        controller: controller,
        child: Column(children: [
          Restaurant(
              title: "Пхали-Хинкали",
              kitchen_type: "Ресторан грузинской кухни",
              address: "Большая Морская ул., 27",
              rating: 4.7,
              image: Image.network(
                "https://incrussia.ru/wp-content/uploads/2018/10/iStock-694189032.jpg",
                fit: BoxFit.cover,
              )),
          Restaurant(
              title: "Название",
              kitchen_type: "Тип кухни",
              address: "Адрес",
              rating: 2.8,
              image: Image.network(
                "http://c.files.bbci.co.uk/9017/production/_105278863_gettyimages-855098134.jpg",
                fit: BoxFit.cover,
              )),
          Restaurant(
              title: "Название",
              kitchen_type: "Тип кухни",
              address: "Адрес",
              rating: 2.8,
              image: Image.network(
                "http://c.files.bbci.co.uk/9017/production/_105278863_gettyimages-855098134.jpg",
                fit: BoxFit.cover,
              )),
          Restaurant(
              title: "Название",
              kitchen_type: "Тип кухни",
              address: "Адрес",
              rating: 2.8,
              image: Image.network(
                "http://c.files.bbci.co.uk/9017/production/_105278863_gettyimages-855098134.jpg",
                fit: BoxFit.cover,
              )),
        ]));
  }
}

class Restaurant extends StatelessWidget {
  final String title;
  final String kitchen_type;
  final String address;
  final double rating;
  final Image image;

  const Restaurant(
      {Key? key,
      required this.title,
      required this.kitchen_type,
      required this.address,
      required this.rating,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = this.title;
    return Padding(
      padding: const Pad(all: 20),
      child: InkWell(
        //inkwell container
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RestarauntPage(
                      title: title,
                      kitchen_type: kitchen_type,
                      rating: rating,
                      image: image,
                      address: address)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 5),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                child: SizedBox(
                  height: 135,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 38,
                        child: Icon(
                          Icons.location_on,
                          size: 18,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 40,
                      child: Text(kitchen_type,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400)),
                    ),
                    Text(address,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                    Text(rating.toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: image,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
