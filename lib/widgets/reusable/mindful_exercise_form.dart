import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/widgets/form_text_field_input.dart';

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
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _imagePath = File(pickedImage.path);
      }
    });
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
              if (_imagePath != null) Image.file(_imagePath!, height: 100),

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
                  _duration = newValue! as int;
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
