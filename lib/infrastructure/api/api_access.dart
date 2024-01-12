import 'package:supabase_flutter/supabase_flutter.dart';

/// Access to Api
class Api{
  static const String url = 'url';
  static const String key = 'key';
  final SupabaseClient supabase = Supabase.instance.client;
}