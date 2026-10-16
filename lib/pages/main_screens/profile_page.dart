import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profiles",
          style: TextStyle(
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.bold,
            fontSize: 29,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Here are your custom exercises",
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 20),

              Consumer<CustomDataProvider>(
                builder: (context, data, child) {
                  List<MeditationExercise> meditationList = data
                      .getMeditationExersices();
                  List<SleepExercise> sleepExercisesList = data
                      .getSleepExercises();
                  List<MindfulnessExercise> mindfulnessData = data
                      .getMindfulnessExercises();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buidTitleWidget(title: "Meditations"),

                      SizedBox(height: 15),

                      meditationList.isEmpty
                          ? Text(
                              "Please enter content to display",
                              style: AppTextStyles.bodyStyle,
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: meditationList.length,
                              itemBuilder: (context, index) {
                                MeditationExercise meditation =
                                    meditationList[index];
                                return _meditationContent(
                                  meditation: meditation,
                                  context: context,
                                );
                              },
                            ),

                      SizedBox(height: 20),

                      _buidTitleWidget(title: "Sleep Content"),

                      SizedBox(height: 15),

                      sleepExercisesList.isEmpty
                          ? Text(
                              "Please enter content to display",
                              style: AppTextStyles.bodyStyle,
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: sleepExercisesList.length,
                              itemBuilder: (context, index) {
                                SleepExercise sleepExersice =
                                    sleepExercisesList[index];
                                return _sleepContent(
                                  sleepExercise: sleepExersice,
                                  context: context,
                                );
                              },
                            ),

                      SizedBox(height: 20),

                      _buidTitleWidget(title: "Mindfulness Exercises"),

                      SizedBox(height: 15),

                      mindfulnessData.isEmpty
                          ? Text(
                              "Please enter content to display",
                              style: AppTextStyles.bodyStyle,
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: mindfulnessData.length,
                              itemBuilder: (context, index) {
                                MindfulnessExercise mindfulness =
                                    mindfulnessData[index];

                                return _mindfulnessContent(
                                  mindfulness: mindfulness,
                                  context: context,
                                );
                              },
                            ),

                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buidTitleWidget({required String title}) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.primaryBlack,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _meditationContent({
    required MeditationExercise meditation,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryDarkBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meditation.name,
                  style: AppTextStyles.subtitleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  meditation.description,
                  style: AppTextStyles.bodyStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Text(
            "${meditation.duration}min",
            style: AppTextStyles.bodyStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _sleepContent({
    required SleepExercise sleepExercise,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryDarkBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sleepExercise.name,
                  style: AppTextStyles.subtitleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  sleepExercise.description,
                  style: AppTextStyles.bodyStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Text(
            "${sleepExercise.duration}min",
            style: AppTextStyles.bodyStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _mindfulnessContent({
    required MindfulnessExercise mindfulness,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryDarkBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mindfulness.name,
                  style: AppTextStyles.subtitleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  mindfulness.description,
                  style: AppTextStyles.bodyStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Text(
            "${mindfulness.duration}min",
            style: AppTextStyles.bodyStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
