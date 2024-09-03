
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/data/datasources/local/db/app_database.dart';


@Singleton()
class DatabaseProvider {

  AppDatabase? _database;

  Future<AppDatabase> getDatabase() async {
    _database ??= await $FloorAppDatabase.databaseBuilder(AppConst.dbName).build();
    return _database!;
  }
}