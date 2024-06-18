import 'package:flutter/material.dart';

import 'package:my_its_anime_list/features/anime_2/constants/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          error,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.blueColor,
          ),
        ),
      ),
    );
  }
}
