library storage;

abstract class Storage {
  Future<void> clearAllStorage();
  Future<bool> containsData({required String key});
  Future<void> delete({required String key});
  Future<dynamic> getData({required String key});
  Future<String?> getToken();
  Future<dynamic> getUser();
  Future<String?> getUserType();
  Future<void> initStorage();
  Future<void> saveToken({required String value});
  Future<void> saveUser({dynamic data});
  Future<void> saveUserType({required String data});
  Future<void> storeData({required String key, dynamic value});
}
