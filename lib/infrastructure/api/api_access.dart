import 'package:supabase_flutter/supabase_flutter.dart';

/// Access to Api
class Api{
  static const String url = 'URL';
  static const String key = 'APIKEY';
  final SupabaseClient supabase = Supabase.instance.client;
}