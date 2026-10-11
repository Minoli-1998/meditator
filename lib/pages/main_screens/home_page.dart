import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/providers/filtered_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<FilteredProvider>(context).getAllData(context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error in loading data"));
          }

          return Consumer<FilteredProvider>(
            builder:
                (
                  BuildContext context,
                  FilteredProvider filterProvider,
                  Widget? child,
                ) {
                  final completedData = filterProvider.filteredData;
                  completedData.shuffle();

                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
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
                                  FilterChip(
                                    label: Text("All"),
                                    onSelected: (value) {},
                                  ),
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

                          SizedBox(height: 20),

                          // gridview using staggered
                          if (completedData.isNotEmpty)
                            StaggeredGrid.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: completedData.map((data) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: data is MindfulnessExercise
                                          ? AppColors.primaryGreen
                                          : data is MeditationExercise
                                          ? AppColors.primaryPurple
                                          : AppColors.primaryDarkBlue
                                                .withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.name,
                                          style: AppTextStyles.titleStyle
                                              .copyWith(
                                                color: AppColors.primaryWhite,
                                              ),
                                        ),

                                        Text(
                                          data.category,
                                          style: AppTextStyles.bodyStyle
                                              .copyWith(
                                                color: AppColors.primaryBlack
                                                    .withValues(alpha: 0.5),
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),

                                        Text(
                                          "${data.duration} min",
                                          style: AppTextStyles.bodyStyle
                                              .copyWith(
                                                color: AppColors.primaryBlack
                                                    .withValues(alpha: 0.5),
                                              ),
                                        ),

                                        Text(
                                          data.description,
                                          style: AppTextStyles.bodyStyle
                                              .copyWith(
                                                color: AppColors.primaryWhite,
                                              ),
                                          maxLines:
                                              (data.description.length / 2)
                                                  .toInt(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  );
                },
          );
        },
      ),
    );
  }
}
