import 'package:flutter/material.dart';

class CustomInfoText extends StatelessWidget {
  final String infoText;
  final String infoDetail;
  const CustomInfoText({
    super.key,
    required this.infoText,
    required this.infoDetail,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            infoText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(infoDetail),
        ],
      ),
    );
  }
}
