import 'package:google_fonts/google_fonts.dart';

import '../../models/courses_model.dart';

bool mode = true;
bool notification = true;
String langTitle = 'ar';
bool isArabic = true;
late double screenHeight;
late double screenWidth;
var font= GoogleFonts.changa();

//user data
String? jwt = '';
String? role = '';
late bool firstInstall;

Future<List<CourseModel>>? allCourse;

const List<String> subjects = [
  'Arabic',
  'English',
  'German',
  'Spanish',
  'Italian',
  'French',
  'Maths',
  'Sciences',
  'SocialStudies',
  'Geography',
  'History',
  'Philosophy',
  'Psychology',
  'Chemistry',
  'Physics',
  'Biology',
  'Geology',
  'ReligiousEducation',
  'Computer',
  'Economics',
  'Statistics',
];
const List<String> stage = [
  'PrimaryStage',
  'PreparatoryStage',
  'SecondaryStage',
];
const List<String> eduLevel = [
  'FirstYear',
  'SecondYear',
  'ThirdYear',
  'FourthYear',
  'FifthYear',
  'SixthYear',
];
const List<String> term = [
  'First',
  'Second',
];