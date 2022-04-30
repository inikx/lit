import 'package:flutter/material.dart';

class SuccessSnackbar extends StatelessWidget {
  final String info;
  const SuccessSnackbar({
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
              color: const Color(0xffDCF3EB),
              border: Border.all(
                color: const Color(0xff34A770),
                width: 0.5,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: Material(
                    color: const Color(0xff34A770),
                    child: InkWell(
                      splashColor: const Color(0xff34A770),
                      onTap: () {},
                      child: const SizedBox(
                          width: 26,
                          height: 26,
                          child: Icon(
                            Icons.check_rounded,
                            size: 15,
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
                      'Успешно',
                      style: TextStyle(
                          color: Color(0xff13854E),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      info,
                      style: TextStyle(
                          color: Color(0xff10673E),
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
