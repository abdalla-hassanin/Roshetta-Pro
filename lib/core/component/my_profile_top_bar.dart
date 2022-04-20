import 'package:flutter/cupertino.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

myProfileTopBar({
  required BuildContext context,
  required String image,
  required String name,
  required String bio,
}) {
  return Column(
    children: [
      Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                image,
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.35,
                fit: BoxFit.cover,
              ),
            )),
      ),
      Text(
        name,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'SST_Arabic',
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: colorBlue4C,
        ),
      ),
      Text(
        bio,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'SST_Arabic',
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: colorGray94,
        ),
      ),
      const SizedBox(
        height: 16,
      ),
    ],
  );
}
