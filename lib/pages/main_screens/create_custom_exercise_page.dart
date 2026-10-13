import 'package:flutter/material.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/widgets/reusable/meditation_form.dart';
import 'package:meditator/widgets/reusable/mindful_exercise_form.dart';
import 'package:meditator/widgets/reusable/sleep_exercise_form.dart';

class CreateCustomExercisePage extends StatefulWidget {
  const CreateCustomExercisePage({super.key});

  @override
  State<CreateCustomExercisePage> createState() =>
      _CreateCustomExercisePageState();
}

class _CreateCustomExercisePageState extends State<CreateCustomExercisePage> {
  // dropdown value content value
  String typeOfContent = "Meditation";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Custom Exercise",
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryPurple,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),

                // drop down list
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withValues(alpha: 0.25),
                      border: Border.all(
                        color: AppColors.primaryPurple,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        focusColor: AppColors.primaryPurple.withValues(
                          alpha: 0.25,
                        ),
                        value: typeOfContent,
                        isExpanded: true,
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColors.primaryPurple,
                        ),
                        items: ["Meditation", "Mindfulness", "Sleep"].map((
                          item,
                        ) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                color: AppColors.primaryDarkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            typeOfContent = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // forms
                typeOfContent == "Meditation"
                    ? MeditationForm()
                    : typeOfContent == "Mindfulness"
                    ? MindfulnessForm()
                    : SleepExerciseForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
