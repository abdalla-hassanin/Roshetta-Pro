import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class CustomProfileTopBar extends StatelessWidget {
  final String image;
  final String name;
  final String bio;

  const CustomProfileTopBar(
      {super.key, required this.image, required this.name, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.35,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no_image.jpg',
                    fit: BoxFit.cover,
                  ),
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
}
