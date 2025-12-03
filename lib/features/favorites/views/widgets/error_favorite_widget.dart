import 'package:flutter/material.dart';

class ErrorFavoriteWidget extends StatelessWidget {
  const ErrorFavoriteWidget({super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 100,
            color: Colors.red,
          ),
          SizedBox(height: 20),
          Text(
            "An error occurred",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: onRetry,
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }
}
