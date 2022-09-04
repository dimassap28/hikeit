import 'package:intl/intl.dart';

// ENVIRONMENT
const String staggingURL = 'http://192.168.0.103:3000';
const String productionURL = 'https://hiking.e-dikmadiun.com';

const String baseURL = productionURL;

// GOOGLE API KEY
String googleAPI = "AIzaSyA1MgLuZuyqR_OGY3ob3M52N46TDBRI_9k";

// NUMBER FORMAT
final numberFormat =
    NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);
