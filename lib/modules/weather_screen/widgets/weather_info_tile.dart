import 'package:flutter/material.dart';

class WeatherInfoTile extends StatelessWidget {
  final Widget iconWidget;
  final String? label;
  final String? value;
  const WeatherInfoTile(
      {super.key,
      required this.iconWidget,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey[100],
          child: iconWidget,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label ?? "",
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            Text(
              value ?? "",
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
