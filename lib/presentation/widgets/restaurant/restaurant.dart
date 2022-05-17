import 'package:flutter/material.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/route.dart';

class RestaurantWidget extends StatelessWidget {
  Restaurant restaurant;

  RestaurantWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
              Navigator.pushNamed(context, RESTAURANT_DETAILS,
                  arguments: RestarauntDetailsArguments(
                      restaurant.title,
                      restaurant.city,
                      restaurant.kitchen,
                      restaurant.address,
                      restaurant.rating,
                      restaurant.imagePath,
                      restaurant.averagePrice,
                      restaurant.shortDescription,
                      restaurant.workingHours,
                      restaurant.phone));
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(27, 0, 0, 0),
                          child: Text(
                            restaurant.title,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Icon(
                                Icons.restaurant_menu,
                                size: 18,
                              ),
                            ),
                            Flexible(
                              child: Text(restaurant.kitchen.join(", "),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Icon(
                                Icons.location_on,
                                size: 18,
                              ),
                            ),
                            Flexible(
                              child: Text(restaurant.address.toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 8, 0),
                                child: Text(
                                  "₽",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )),
                            Text(
                                restaurant.averagePrice != 0
                                    ? restaurant.averagePrice.toString()
                                    : "Нет данных",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Icon(
                                Icons.star,
                                size: 18,
                              ),
                            ),
                            Text(
                                restaurant.rating != 0
                                    ? restaurant.rating.toString()
                                    : "Нет оценок",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400)),
                          ],
                        ),
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
                          child: Image.network(
                            restaurant.imagePath.first,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
