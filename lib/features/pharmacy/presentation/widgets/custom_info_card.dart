import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class CustomInfoCard extends StatelessWidget {
 final String name;
 final String email;
 final String mobilePhone;
 final String image;
 final Widget navigateToWidget;

  const CustomInfoCard(
      {super.key,
      required this.name,
      required this.email,
      required this.mobilePhone,
      required this.image,
      required this.navigateToWidget,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      color: colorGrayF9,
      child: Row(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                image,
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width * 0.25,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Iconify(
                        Ic.baseline_person_outline,
                        color: colorGray94,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'SST_Arabic',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: colorBlue4C,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Iconify(
                        Dashicons.email_alt,
                        color: colorGray94,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        email,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'SST_Arabic',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: colorGray94,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Iconify(
                        Ic.baseline_phone,
                        color: colorGray94,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        mobilePhone,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'SST_Arabic',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: colorGray94,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => navigateToWidget));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            Directionality.of(context) == TextDirection.rtl
                                ? 'assets/images/enter_right.png'
                                : 'assets/images/enter.png',
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
