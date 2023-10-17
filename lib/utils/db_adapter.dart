abstract class DbAdapter<T> {
  Future<T> openDb();
  Future<T> getInstance();
  Future<void> insert(String table, Map<String, Object> data);
  Future<List<Map<String, Object?>>> query(String table);
}
