import 'package:flutter/material.dart';
import 'package:meditator/models/functions_data_model.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FunctionsPage extends StatefulWidget {
  final FunctionsData functionData;
  const FunctionsPage({super.key, required this.functionData});

  @override
  State<FunctionsPage> createState() => _FunctionsPageState();
}

class _FunctionsPageState extends State<FunctionsPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // get video id
    final videoId =
        YoutubePlayerController.convertUrlToId(widget.functionData.url) ?? "";

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.functionData.title,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: YoutubePlayer(controller: _controller),
                ),
              ),

              SizedBox(height: 40),

              Text(
                "Duration : ${widget.functionData.duration} min",
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.primaryGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              // category
              Text(
                "Category : ${widget.functionData.category}",
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.primaryGreen,
                ),
              ),

              SizedBox(height: 20),

              // description
              Text(
                widget.functionData.description,
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.primaryBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
