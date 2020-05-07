import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<List<String>> loadSearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('search') ?? List<String>();
  }

  Future<void> storeSearch(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searches = await loadSearch();
    if (!searches.contains(search)) {
      searches.add(search);
    }
    return prefs.setStringList('search', searches);
  }

  Future<void> removeSearch(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searches = await loadSearch();
    searches.removeWhere((String string) => string == search);
    return prefs.setStringList('search', searches);
  }
}
