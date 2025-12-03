import 'package:flutter/material.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';

class EmptyFavoriteWidget extends StatelessWidget {
  const EmptyFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            "No favorites yet!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Add some news to your favorites to see them here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.homeRoute); // Assuming you have a home route
            },
            child: Text("Browse News"),
          ),
        ],
      ),
    );
  }
}
