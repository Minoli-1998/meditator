import 'package:flutter/material.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/providers/mindfull_exercise_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class MindfullExercisePage extends StatelessWidget {
  const MindfullExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mindfull Exercises",
          style: TextStyle(
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.bold,
            fontSize: 29,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              Column(
                children: [
                  // search
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.primaryGrey,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primaryGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),

                    // todo : implement the search functinality here
                    onChanged: (value) {
                      Provider.of<MindfullExerciseProvider>(
                        context,
                        listen: false,
                      ).searchMindfulnessExercises(value);
                    },
                  ),

                  SizedBox(height: 20),

                  Consumer<MindfullExerciseProvider>(
                    builder:
                        (
                          BuildContext context,
                          MindfullExerciseProvider mindfulProvider,
                          Widget? child,
                        ) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              shrinkWrap: false,
                              itemCount: mindfulProvider.getAllData().length,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                MindfulnessExercise exercise = mindfulProvider
                                    .getAllData()[index];

                                return Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDarkBlue.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(10),
                                    leading: ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(100),
                                      child: Image.asset(
                                        exercise.imagePath,
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.13,
                                        height:
                                            MediaQuery.of(context).size.width *
                                            0.13,
                                      ),
                                    ),

                                    title: Text(
                                      exercise.name,
                                      style: AppTextStyles.subtitleStyle,
                                    ),

                                    subtitle: Text(
                                      exercise.description,
                                      style: AppTextStyles.bodyStyle,
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
