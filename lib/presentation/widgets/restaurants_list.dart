import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:lit/presentation/pages/restaurant_page.dart';

class RestaurantsList extends StatelessWidget {
  const RestaurantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        child: Column(children: [
          Restaurant(
            title: "Пхали-Хинкали",
            kitchenType: "Ресторан грузинской кухни",
            address: "Большая Морская ул., 27",
            rating: 4.7,
            image: Image.network(
              "https://incrussia.ru/wp-content/uploads/2018/10/iStock-694189032.jpg",
              fit: BoxFit.cover,
            ),
            price: 1000,
            description:
                "Грузинская кухня и европейское гостеприимство - семья ресторанов «Пхали Хинкали» - вкусный и душевный проект с новым качественным подходом к кавказской кухне. Домашняя обстановка, приятные цены, оригинальные рецепты, европейский подход, радушие и гостеприимство – все это ждет вас в Пхали-Хинкали.",
          ),
          Restaurant(
            title: "Название",
            kitchenType: "Тип кухни",
            address: "Адрес",
            rating: 2.8,
            image: Image.network(
              "http://c.files.bbci.co.uk/9017/production/_105278863_gettyimages-855098134.jpg",
              fit: BoxFit.cover,
            ),
            price: 1000,
            description:
                "ыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыыы",
          ),
          Restaurant(
            title: "Название",
            kitchenType: "Тип кухни",
            address: "Адрес",
            rating: 2.8,
            image: Image.network(
              "http://c.files.bbci.co.uk/9017/production/_105278863_gettyimages-855098134.jpg",
              fit: BoxFit.cover,
            ),
            price: 1000,
            description: "фыовддлофыводфлыволдфыводфлыовдлфоывд",
          ),
          Restaurant(
            title: "Название",
            kitchenType: "Тип кухни",
            address: "Адрес",
            rating: 2.8,
            image: Image.network(
              "http://c.files.bbci.co.uk/9017/production/_105278863_gettyimages-855098134.jpg",
              fit: BoxFit.cover,
            ),
            price: 1000,
            description: "фыовддлофыводфлыволдфыводфлыовдлфоывд",
          ),
        ]));
  }
}

class Restaurant extends StatelessWidget {
  final String title;
  final String kitchenType;
  final String address;
  final double rating;
  final Image image;
  final int price;
  final String description;

  const Restaurant(
      {Key? key,
      required this.title,
      required this.kitchenType,
      required this.address,
      required this.rating,
      required this.image,
      required this.price,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const Pad(all: 22),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            splashColor: Colors.blueGrey[250],
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RestarauntPage(
                            title: title,
                            kitchenType: kitchenType,
                            address: address,
                            rating: rating,
                            image: image,
                            price: price,
                            description: description,
                          )));
            },
            child: SizedBox(
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
                        children: const [
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
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 40,
                          child: Text(kitchenType,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400)),
                        ),
                        Text(address,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        Text(rating.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SizedBox(
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
        ),
      ),
    );
  }
}
