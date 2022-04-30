import 'package:flutter/material.dart';

class ErrorSnackbar extends StatelessWidget {
  final String info;
  const ErrorSnackbar({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
          height: 65,
          decoration: BoxDecoration(
              color: const Color(0xffFFF8F8),
              border: Border.all(
                color: const Color(0xffF85640),
                width: 0.5,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: Material(
                    color: const Color(0xffF85640),
                    child: InkWell(
                      splashColor: const Color(0xffF85640),
                      onTap: () {},
                      child: const SizedBox(
                          width: 26,
                          height: 26,
                          child: Icon(
                            Icons.dangerous_outlined,
                            size: 20,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 15, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Что-то пошло не так',
                      style: TextStyle(
                          color: Color(0xffF85640),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      info,
                      style: TextStyle(
                          color: Color(0xff79170A),
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
