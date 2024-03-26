import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environtment {
  static get supabaseUrl  =>  dotenv.env["SUPABASE_PROJECT_URL"];
  static get supabaseAnnonKey =>  dotenv.env["SUPABASE_ANNON_KEY"];
  
} 