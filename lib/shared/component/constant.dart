import 'package:google_fonts/google_fonts.dart';
import 'package:signalr_netcore/hub_connection.dart';

bool mode = true;
bool notification = true;
String langTitle = 'ar';
bool isArabic = true;
late double screenHeight;
late double screenWidth;
var font= GoogleFonts.changa();
late HubConnection hubConnection;
//user data
String? jwt = '';
String? role = '';
late bool firstInstall;


const List<String> subjects = [
  'Arabic',
  'English',
  'Maths',
  'Sciences',
  'SocialStudies',
  'German',
  'Spanish',
  'Italian',
  'French',
  'History',
  'Geography',
  'Chemistry',
  'Physics',
  'Philosophy',
  'Psychology',
  'Biology',
  'Geology',
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