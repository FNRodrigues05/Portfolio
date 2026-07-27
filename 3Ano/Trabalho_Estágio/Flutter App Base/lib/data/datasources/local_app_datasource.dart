import 'package:exercicio_um/domain/errors/app_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppDataSource {
  Future<AppError?> saveCounter(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var didSaveCounter = await prefs.setInt('counter', value);
    if (didSaveCounter) return null;

    return const Unknown();
  }

  Future<int?> getCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var didGetCounter = await prefs.getInt('counter') ?? 0;

    return didGetCounter;
  }

  Future<AppError?> saveName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var didSaveName = await prefs.setString('name', name);

    if (didSaveName) return null;

    return const Unknown();
  }

  Future<String?> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var didGetName = await prefs.getString('name') ?? '';

    return didGetName;
  }

  Future<AppError?> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var didClearAll = await prefs.clear();

    if (didClearAll) return null;

    return const Unknown();
  }
}
