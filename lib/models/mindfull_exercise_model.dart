class MindfulnessExercise {
  final String category;
  final String name;
  final String description;
  final List<String> instructions;
  final int duration;
  final String instructionUrl;
  final String imagePath;

  MindfulnessExercise({
    required this.category,
    required this.name,
    required this.description,
    required this.instructionUrl,
    required this.imagePath,
    required this.instructions,
    required this.duration,
  });

  // method to convert the json data to a MindfulnessExercise
  factory MindfulnessExercise.fromJson(Map<String, dynamic> json) {
    return MindfulnessExercise(
      category: json['category'],
      name: json['name'],
      description: json['description'],
      instructionUrl: json['instruction_url'],
      imagePath: json['image_path'],
      instructions: List<String>.from(json['instructions']),
      duration: json['duration'],
    );
  }

  // convert MindfulnessExercise to JSON data
  Map<String, dynamic> toJSON() {
    return {
      'category': category,
      'name': name,
      'description': description,
      'instruction_url': instructionUrl,
      'image_path': imagePath,
      'instructions': instructions,
      'duration': duration,
    };
  }
}
