/// Base Api Interface [BaseApiImpl]
///
/// This is the base interface for the Api.
abstract class BaseApiImpl{
  Future<List<Map<String, dynamic>>> get({required String path});
  Future<void> post( String path, Map<dynamic, dynamic> entity);
  Future<List<Map<String, dynamic>>> getById({required String path,required String id});
  Stream<List<Map<String, dynamic>>> getStream({required String path, required String key});
}