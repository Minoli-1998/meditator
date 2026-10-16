import 'package:flutter/material.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class MindfullExerciseTab extends StatelessWidget {
  const MindfullExerciseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Consumer<CustomDataProvider>(
              builder: (context, mindfulnessData, child) {
                final List<MindfulnessExercise> mindfulnessExersices =
                    mindfulnessData.getMindfulnessExercises();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: mindfulnessExersices.length,
                  itemBuilder: (context, index) {
                    MindfulnessExercise exercise = mindfulnessExersices[index];

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
                                  mindfulnessData.deleteMindfulness(
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
