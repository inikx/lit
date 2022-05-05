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
      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
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
                      restaurant.kitchen,
                      restaurant.address,
                      restaurant.rating,
                      restaurant.imagePath,
                      restaurant.averagePrice,
                      restaurant.description,
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
                          restaurant.title,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 40,
                          child: Text(restaurant.shortDescription,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400)),
                        ),
                        Text(restaurant.address.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        Text(restaurant.rating.toString(),
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
                          child: Image.network(
                            //restaurant.imagePath!.first //TODO: fix
                            "https://incrussia.ru/wp-content/uploads/2018/10/iStock-694189032.jpg",
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
