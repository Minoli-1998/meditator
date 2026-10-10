import 'package:flutter/material.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/meditation.png",
                    width: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(width: 10),

                  Text(
                    "Meditator",
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Text(
                "Select a category to start exploring",
                style: AppTextStyles.subtitleStyle.copyWith(
                  color: AppColors.primaryDarkBlue,
                ),
              ),

              SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 24,
                    children: [
                      FilterChip(label: Text("All"), onSelected: (value) {}),
                      FilterChip(
                        label: Text("Mindfulness"),
                        onSelected: (value) {},
                      ),
                      FilterChip(
                        label: Text("Meditation"),
                        onSelected: (value) {},
                      ),
                      FilterChip(
                        label: Text("Sleep Stories"),
                        onSelected: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
