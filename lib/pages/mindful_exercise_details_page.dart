import 'package:flutter/material.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MindfulExerciseDetailsPage extends StatelessWidget {
  final MindfulnessExercise mindfulExercise;
  const MindfulExerciseDetailsPage({super.key, required this.mindfulExercise});

  // method to get url
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch $uri";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mindfull Exercise Details",
          style: TextStyle(
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.bold,
            fontSize: 29,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mindfulExercise.name, style: AppTextStyles.titleStyle),

                SizedBox(height: 15),

                Text(
                  mindfulExercise.category,
                  style: AppTextStyles.subtitleStyle,
                ),

                SizedBox(height: 15),

                Text(
                  mindfulExercise.description,
                  style: AppTextStyles.bodyStyle,
                ),

                SizedBox(height: 15),

                Text("Instructions", style: AppTextStyles.subtitleStyle),

                SizedBox(height: 15),

                ...mindfulExercise.instructions.map(
                  (instruction) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, size: 8),

                        SizedBox(width: 5),

                        Text(instruction, style: AppTextStyles.bodyStyle),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 25),

                Row(
                  children: [
                    Icon(Icons.timer, color: AppColors.primaryGrey),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "${mindfulExercise.duration} minutes",
                        style: AppTextStyles.bodyStyle,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    await _launchUrl(mindfulExercise.instructionUrl);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.primaryGreen,
                    ),
                  ),
                  child: Text(
                    "View Detailed Instructions",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
