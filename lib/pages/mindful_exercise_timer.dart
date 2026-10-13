import 'package:flutter/material.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/utils/colors.dart';

class MindfulExerciseTimer extends StatelessWidget {
  final MindfulnessExercise exercise;
  const MindfulExerciseTimer({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise.name,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.category,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  exercise.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlack,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  "Duration : ${exercise.duration} minutes",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  exercise.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  "Instructions:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlack,
                  ),
                ),

                SizedBox(height: 15),

                ...exercise.instructions.map((instruction) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.2),
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      instruction,
                      style: TextStyle(
                        color: AppColors.primaryBlack,
                        fontSize: 16,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
