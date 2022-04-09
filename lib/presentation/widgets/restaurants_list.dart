import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:google_maps_webservice/places.dart';
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
                textCapitalization: TextCapitalization.words,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Поиск',
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                )),
          ),
          Restaurant(
            title: "Пхали-Хинкали",
            kitchenType: "Грузинская кухня",
            address: "Большая Морская ул., 27",
            rating: 4.7,
            image: Image.network(
              "https://cdn.images.restoclub.ru/uploads/place_thumbnail_big/1/2/8/c/128c1b700e3dd4d63f4dff3b699172d2.jpg",
              fit: BoxFit.cover,
            ),
            price: "₽₽₽",
            description:
                "Грузинская кухня и европейское гостеприимство - семья ресторанов «Пхали Хинкали» - вкусный и душевный проект с новым качественным подходом к кавказской кухне. Домашняя обстановка, приятные цены, оригинальные рецепты, европейский подход, радушие и гостеприимство – все это ждет вас в Пхали-Хинкали.",
          ),
          Restaurant(
            title: "Юми",
            kitchenType: "Китайская кухня",
            address: "ул. Разъезжая 10",
            rating: 4.8,
            image: Image.network(
              "https://cdn.images.restoclub.ru/uploads/place_thumbnail_big/6/1/d/b/61db7087cede8f68d2cf39f79c249490.jpg",
              fit: BoxFit.cover,
            ),
            price: "₽₽₽",
            description:
                "Ресторан «Юми», открывшийся в начале 2016 года на улице Разъезжей, предлагает гостям аутентичную китайскую кухню в стильном современном интерьере.",
          ),
          Restaurant(
            title: "Room DND",
            kitchenType: "Японская кухня",
            address: "Суворовский пр. 18",
            rating: 4.8,
            image: Image.network(
              "https://cdn.images.restoclub.ru/uploads/place_thumbnail_big/9/0/1/f/901f4ec1b2d1c6905dc63567936a141b.jpg",
              fit: BoxFit.cover,
            ),
            price: "₽₽₽",
            description:
                "Японский секретный ресторан в Grand Hotel Emerald на Суворовском проспекте. Название спикизи-ресторана расшифровывается как просьба не беспокоить на ручке номера отеля.   ",
          ),
          Restaurant(
            title: "Гуси-лебеди",
            kitchenType: "Русская кухня",
            address: "пр. Коломяжский 19/2",
            rating: 4.0,
            image: Image.network(
              "https://cdn.images.restoclub.ru/uploads/place_thumbnail_big/0/3/5/8/0358490d24c9e6dfe026a806c0207bd2.jpg",
              fit: BoxFit.cover,
            ),
            price: "₽₽₽",
            description:
                "Семейный ресторан «Гуси-лебеди» смело можно назвать уникальным. И дело не только в огромных масштабах, невероятном интерьере и гигантском меню, хотя и это, конечно, впечатляет. Главное, что такой русской кухни, как здесь, вы не пробовали никогда – и это не художественное преувеличение.",
          ),
          Restaurant(
            title: "Medici",
            kitchenType: "Итальянская кухня",
            address: "пр. Медиков 10к1",
            rating: 4.5,
            image: Image.network(
              "https://cdn.images.restoclub.ru/uploads/place_thumbnail_big/e/6/d/0/e6d083b9da6e81f72a8d77707f5266ac.jpg",
              fit: BoxFit.cover,
            ),
            price: "₽₽₽",
            description:
                "Какие гастрономические образы возникают в воображении, когда вы думаете об Италии? Свежеиспеченная чиабатта, спелый виноград, нежнейшая расплавленная моцарелла и ароматный кофе… Именно такую — сочную — Италию можно найти в ресторане Medici на проспекте Медиков. ",
          ),
        ]));
  }
}

class Restaurant extends StatelessWidget {
  final String title;
  final String kitchenType;
  final String? address;
  final num? rating;
  final Image image;
  final String price; //icon
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
      padding: const Pad(all: 20),
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
                        Text(address.toString(),
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
