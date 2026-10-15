import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/widgets/form_text_field_input.dart';
import 'package:provider/provider.dart';

class MindfulnessForm extends StatefulWidget {
  const MindfulnessForm({super.key});

  @override
  State<MindfulnessForm> createState() => _MindfulnessFormState();
}

class _MindfulnessFormState extends State<MindfulnessForm> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // values of text fields
  String _category = "";
  String _name = "";
  String _description = "";
  int _duration = 0;
  String _instructionUrl = "";
  List<String> _instructions = [];
  File? _imagePath;

  final ImagePicker _imagePicker = ImagePicker();

  // method to pick the image
  // Future<void> _pickImage(ImageSource source) async {
  //   final pickedImage = await _imagePicker.pickImage(source: source);

  //   setState(() {
  //     if (pickedImage != null) {
  //       _imagePath = File(pickedImage.path);
  //     }
  //   });
  // }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(source: source);

      if (pickedImage != null && mounted) {
        setState(() {
          _imagePath = File(pickedImage.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create a new mindfull exercise",
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
              // displaying selected image
              // if (_imagePath != null) Image.file(_imagePath!, height: 100),
              if (_imagePath != null) ...[
                Center(
                  child: Image.file(
                    _imagePath!,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Unable to display selected image');
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              // buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: Text("Pick from Camera"),
                  ),

                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: Text("Pick from Gallery"),
                  ),
                ],
              ),

              SizedBox(height: 15),

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

              // instructions
              FormTextFieldInput(
                hintText: "Instructions",
                lableText: 'Instructions',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter instructions";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _instructions = newValue!.split(',');
                },
                keyboardType: TextInputType.text,
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
                  _duration = int.parse(newValue!);
                },
              ),

              SizedBox(height: 10),

              // instruction url
              FormTextFieldInput(
                hintText: "Instruction Url",
                lableText: 'Instruction Url',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter instruction URL";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _instructionUrl = newValue!;
                },
              ),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final imagePathString = _imagePath?.path ?? "";

                        // getting user enter data
                        final mindfulnessExercise = MindfulnessExercise(
                          category: _category,
                          name: _name,
                          description: _description,
                          instructionUrl: _instructionUrl,
                          imagePath: imagePathString,
                          instructions: _instructions,
                          duration: _duration,
                        );

                        // clear data
                        _formKey.currentState!.reset();
                        _category = "";
                        _name = "";
                        _description = "";
                        _instructionUrl = "";
                        _instructions = [];
                        _duration = 0;
                        _imagePath = null;

                        Provider.of<CustomDataProvider>(
                          context,
                          listen: false,
                        ).addMindfulnessExercise(mindfulnessExercise, context);
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
