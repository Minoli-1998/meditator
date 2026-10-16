import 'package:flutter/material.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class SleepExerciseTab extends StatelessWidget {
  const SleepExerciseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Consumer<CustomDataProvider>(
              builder: (context, sleepExersicesData, child) {
                final List<SleepExercise> sleepExersices = sleepExersicesData
                    .getSleepExercises();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sleepExersices.length,
                  itemBuilder: (context, index) {
                    SleepExercise exercise = sleepExersices[index];

                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          // title row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                exercise.name,
                                style: AppTextStyles.subtitleStyle,
                              ),

                              IconButton(
                                onPressed: () {
                                  sleepExersicesData.deleteSleepExersice(
                                    exercise,
                                    context,
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColors.primaryPurple,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          Text(
                            exercise.description,
                            style: AppTextStyles.bodyStyle,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
