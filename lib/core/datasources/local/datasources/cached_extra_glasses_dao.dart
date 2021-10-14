import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:sembast/sembast.dart';

import 'app_database.dart';

class CachedExtraGlassesDao {
  static const String ExtraGlasses_STORE_NAME = 'extra_glasses_dao';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are category objects converted to Map
  final _extraGlassesStore = intMapStoreFactory.store(ExtraGlasses_STORE_NAME);
  int keyId = 1;
  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(ExtraGlassesEntity appInfo) async {
    print('insert item ${appInfo.toJson()}');
    await _extraGlassesStore.add(await _db, appInfo.toJson());
  }

  Future updateOrInsert(ExtraGlassesEntity appInfo) async {
    await _extraGlassesStore.record(keyId).put(await _db, appInfo.toJson());
  }

  Future update(ExtraGlassesEntity appInfo) async {
    final finder = Finder(filter: Filter.byKey(keyId));
    await _extraGlassesStore.update(
      await _db,
      appInfo.toJson(),
      finder: finder,
    );
  }

  Future delete(ExtraGlassesEntity appInfo) async {
    final finder = Finder(filter: Filter.byKey(keyId));
    await _extraGlassesStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<ExtraGlassesEntity?> getExtraGlasses() async {
    var map = await _extraGlassesStore.record(keyId).get(await _db);
    return map == null ? null : ExtraGlassesEntity.fromJson(map);
  }
}
