import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class CustomMedicalHistoryCard extends StatelessWidget {
  final String doctorName;
  final String bodyText;
  final String date;
  final String image;

  const CustomMedicalHistoryCard({
    super.key,
    required this.doctorName,
    required this.bodyText,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  image,
                  height: MediaQuery.of(context).size.height * 0.2,
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
                color: colorGrayF9,
              ),
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
    );
  }
}
