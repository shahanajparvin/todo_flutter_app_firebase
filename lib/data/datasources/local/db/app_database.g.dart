// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao? _taskDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `task` (`id` TEXT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `isCompleted` INTEGER NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `category` TEXT NOT NULL, `isSynced` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskEntityInsertionAdapter = InsertionAdapter(
            database,
            'task',
            (TaskEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'isCompleted': item.isCompleted ? 1 : 0,
                  'date': item.date,
                  'time': item.time,
                  'category': item.category,
                  'isSynced': item.isSynced ? 1 : 0
                }),
        _taskEntityUpdateAdapter = UpdateAdapter(
            database,
            'task',
            ['id'],
            (TaskEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'isCompleted': item.isCompleted ? 1 : 0,
                  'date': item.date,
                  'time': item.time,
                  'category': item.category,
                  'isSynced': item.isSynced ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskEntity> _taskEntityInsertionAdapter;

  final UpdateAdapter<TaskEntity> _taskEntityUpdateAdapter;

  @override
  Future<List<TaskEntity>?> getTasks() async {
    return _queryAdapter.queryList('select * from task',
        mapper: (Map<String, Object?> row) => TaskEntity(
            id: row['id'] as String?,
            title: row['title'] as String,
            description: row['description'] as String,
            isCompleted: (row['isCompleted'] as int) != 0,
            date: row['date'] as String,
            time: row['time'] as String,
            category: row['category'] as String,
            isSynced: (row['isSynced'] as int) != 0));
  }

  @override
  Future<List<TaskEntity>?> getUnsyncedTasks() async {
    return _queryAdapter.queryList('SELECT * FROM task WHERE isSynced = 0',
        mapper: (Map<String, Object?> row) => TaskEntity(
            id: row['id'] as String?,
            title: row['title'] as String,
            description: row['description'] as String,
            isCompleted: (row['isCompleted'] as int) != 0,
            date: row['date'] as String,
            time: row['time'] as String,
            category: row['category'] as String,
            isSynced: (row['isSynced'] as int) != 0));
  }

  @override
  Future<TaskEntity?> getTaskById(String id) async {
    return _queryAdapter.query('select * from task WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TaskEntity(
            id: row['id'] as String?,
            title: row['title'] as String,
            description: row['description'] as String,
            isCompleted: (row['isCompleted'] as int) != 0,
            date: row['date'] as String,
            time: row['time'] as String,
            category: row['category'] as String,
            isSynced: (row['isSynced'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteTaskById(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM task WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> updateIsCompleted(
    String id,
    bool isCompleted,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE task SET isCompleted = ?2 WHERE id = ?1',
        arguments: [id, isCompleted ? 1 : 0]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM task');
  }

  @override
  Future<void> save(List<TaskEntity> tasks) async {
    await _taskEntityInsertionAdapter.insertList(
        tasks, OnConflictStrategy.replace);
  }

  @override
  Future<void> insert(TaskEntity updateTaskEntity) async {
    await _taskEntityInsertionAdapter.insert(
        updateTaskEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTask(TaskEntity updateTaskEntity) async {
    await _taskEntityUpdateAdapter.update(
        updateTaskEntity, OnConflictStrategy.replace);
  }
}
