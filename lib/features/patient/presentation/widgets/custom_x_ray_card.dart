import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class CustomXRayCard extends StatelessWidget {
  final String xrayImage;

  final String xrayName;

  final String xrayLab;

  final String doctorImage;

  final String doctorName;

  final String date;

  final String bodyText;

  const CustomXRayCard({
    super.key,
    required this.xrayImage,
    required this.xrayName,
    required this.xrayLab,
    required this.doctorImage,
    required this.doctorName,
    required this.date,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: colorGrayF9,
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: imagePreview(
                  xrayImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      xrayName,
                      style: TextStyle(
                        fontFamily: 'SST_Arabic',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: colorBlue4C,
                      ),
                    ),
                    Text(
                      xrayLab,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'SST_Arabic',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: colorGray94,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                doctorImage,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.25,
                                fit: BoxFit.cover,
                              ),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        doctorName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'SST_Arabic',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: colorBlue4C,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        date,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'SST_Arabic',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: colorGray94,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    bodyText,
                                    style: TextStyle(
                                      fontFamily: 'SST_Arabic',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: colorBlue4C,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
