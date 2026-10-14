import 'package:flutter/material.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/widgets/form_text_field_input.dart';

class MeditationForm extends StatefulWidget {
  const MeditationForm({super.key});

  @override
  State<MeditationForm> createState() => _MeditationFormState();
}

class _MeditationFormState extends State<MeditationForm> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // values of text fields
  String _category = "";
  String _name = "";
  String _description = "";
  int _duration = 0;
  String _audioUrl = "";
  String _videoUrl = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create a new meditation",
          style: TextStyle(
            color: AppColors.primaryGreen,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 20),

        Form(
          key: _formKey,
          child: Column(
            children: [
              // category
              FormTextFieldInput(
                hintText: "Category",
                lableText: 'Category',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter category";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _category = newValue!;
                },
              ),

              SizedBox(height: 10),

              // name
              FormTextFieldInput(
                hintText: "Name",
                lableText: 'Name',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter category";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _name = newValue!;
                },
              ),

              SizedBox(height: 10),

              // description
              FormTextFieldInput(
                hintText: "Description",
                lableText: 'Description',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _description = newValue!;
                },
              ),

              SizedBox(height: 10),

              // duration
              FormTextFieldInput(
                hintText: "Duration",
                lableText: 'Duration',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter duration";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _duration = newValue! as int;
                },
              ),

              SizedBox(height: 10),

              // audio url
              FormTextFieldInput(
                hintText: "Audio Url",
                lableText: 'Audio Url',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter audio URL";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _audioUrl = newValue!;
                },
              ),

              SizedBox(height: 10),

              // video url
              FormTextFieldInput(
                hintText: "Video Url",
                lableText: 'Video Url',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter video URL";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _videoUrl = newValue!;
                },
              ),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // save values in local storage

                        // clear fields
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.primaryGreen,
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
