import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditator/models/functions_data_model.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';

class MeditationBottomSheet extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final int duration;
  final String url;

  const MeditationBottomSheet({
    super.key,
    required this.name,
    required this.category,
    required this.description,
    required this.duration,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name
          Text(
            name,
            style: TextStyle(
              color: AppColors.primaryPurple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 20),

          // category
          Text(
            category,
            style: AppTextStyles.bodyStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGrey,
            ),
          ),

          SizedBox(height: 15),

          // description
          Text(
            description,
            style: AppTextStyles.bodyStyle,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 20),

          // duration
          Text(
            "$duration min",
            style: AppTextStyles.bodyStyle.copyWith(
              color: AppColors.primaryGreen,
            ),
          ),

          SizedBox(height: 20),

          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // navigate to functions page
                  GoRouter.of(context).push(
                    '/functions',
                    extra: FunctionsData(
                      title: name,
                      duration: duration,
                      category: category,
                      description: description,
                      url: url,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.primaryGreen,
                  ),
                ),
                child: Text(
                  "Start",
                  style: TextStyle(color: AppColors.primaryBlack),
                ),
              ),

              SizedBox(width: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.primaryGrey,
                  ),
                ),
                child: Text(
                  "Close",
                  style: TextStyle(color: AppColors.primaryBlack),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
