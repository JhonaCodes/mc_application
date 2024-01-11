import 'dart:developer';

import 'package:deepstatemanagment/infrastructure/api/api_access.dart';
import 'package:deepstatemanagment/infrastructure/api/base_api_impl.dart';
import 'package:deepstatemanagment/infrastructure/handle_response.dart';

/// Api supabase Dao
class APiDao extends Api implements BaseApiImpl {

  /// Get all data
  @override
  Future<List<Map<String, dynamic>>> get({required String path}) async{
    /// You can implement any try catch or error handling here.
    log("${supabase.rest.url.toString()}/$path");
    return await supabase.from(path).select();
  }

  @override
  Future<List<Map<String, dynamic>>> getById({required String path, required String id}) async{
    /// Simple and ugly example for error handling
    return await supabase.from(path).select().eq('id', id).catchError(HandleResponse.fromError);
  }

  @override
  Future<void> post(String path,Map<dynamic, dynamic> entity) async{
    await supabase.from(path).insert(entity).catchError(HandleResponse.fromError);
  }

  @override
  Stream<List<Map<String, dynamic>>> getStream({required String path, required String key}) async* {
    yield* supabase.from(path).stream(primaryKey: [key]);
  }


}