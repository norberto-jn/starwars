// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  FavoriteDAO? _favoriteDAOInstance;

  PeopleDAO? _peopleDAOInstance;

  FilmsDAO? _filmsDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `favorite` (`code` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `isSelected` INTEGER NOT NULL, `identificationCode` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `people` (`code` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `isSelected` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `films` (`code` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `isSelected` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoriteDAO get favoriteDAO {
    return _favoriteDAOInstance ??= _$FavoriteDAO(database, changeListener);
  }

  @override
  PeopleDAO get peopleDAO {
    return _peopleDAOInstance ??= _$PeopleDAO(database, changeListener);
  }

  @override
  FilmsDAO get filmsDAO {
    return _filmsDAOInstance ??= _$FilmsDAO(database, changeListener);
  }
}

class _$FavoriteDAO extends FavoriteDAO {
  _$FavoriteDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _favoriteEntityInsertionAdapter = InsertionAdapter(
            database,
            'favorite',
            (FavoriteEntity item) => <String, Object?>{
                  'code': item.code,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0,
                  'identificationCode': item.identificationCode
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteEntity> _favoriteEntityInsertionAdapter;

  @override
  Future<List<FavoriteEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM favorite',
        mapper: (Map<String, Object?> row) => FavoriteEntity(
            row['code'] as int?,
            row['name'] as String,
            (row['isSelected'] as int) != 0,
            row['identificationCode'] as String));
  }

  @override
  Stream<FavoriteEntity?> findOne(int code) {
    return _queryAdapter.queryStream('SELECT * FROM favorite WHERE code = ?1',
        mapper: (Map<String, Object?> row) => FavoriteEntity(
            row['code'] as int?,
            row['name'] as String,
            (row['isSelected'] as int) != 0,
            row['identificationCode'] as String),
        arguments: [code],
        queryableName: 'favorite',
        isView: false);
  }

  @override
  Future<FavoriteEntity?> getByName(String name) async {
    return _queryAdapter.query('SELECT * FROM favorite WHERE name = ?1',
        mapper: (Map<String, Object?> row) => FavoriteEntity(
            row['code'] as int?,
            row['name'] as String,
            (row['isSelected'] as int) != 0,
            row['identificationCode'] as String),
        arguments: [name]);
  }

  @override
  Future<void> delete(int code) async {
    await _queryAdapter.queryNoReturn('DELETE FROM favorite WHERE code = ?1',
        arguments: [code]);
  }

  @override
  Future<void> deleteByIdentificationCode(String identificationCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM favorite WHERE identificationCode = ?1',
        arguments: [identificationCode]);
  }

  @override
  Future<void> save(FavoriteEntity favoriteModel) async {
    await _favoriteEntityInsertionAdapter.insert(
        favoriteModel, OnConflictStrategy.abort);
  }
}

class _$PeopleDAO extends PeopleDAO {
  _$PeopleDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _peopleEntityInsertionAdapter = InsertionAdapter(
            database,
            'people',
            (PeopleEntity item) => <String, Object?>{
                  'code': item.code,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PeopleEntity> _peopleEntityInsertionAdapter;

  @override
  Future<List<PeopleEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM people',
        mapper: (Map<String, Object?> row) => PeopleEntity(row['code'] as int?,
            row['name'] as String, (row['isSelected'] as int) != 0));
  }

  @override
  Future<PeopleEntity?> findOne(int code) async {
    return _queryAdapter.query('SELECT * FROM people WHERE code = ?1',
        mapper: (Map<String, Object?> row) => PeopleEntity(row['code'] as int?,
            row['name'] as String, (row['isSelected'] as int) != 0),
        arguments: [code]);
  }

  @override
  Future<PeopleEntity?> getByName(String name) async {
    return _queryAdapter.query('SELECT * FROM people WHERE name = ?1',
        mapper: (Map<String, Object?> row) => PeopleEntity(row['code'] as int?,
            row['name'] as String, (row['isSelected'] as int) != 0),
        arguments: [name]);
  }

  @override
  Future<void> columnUpdateIsSelect(int code, bool isSelected) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE people SET isSelected = ?2 WHERE code = ?1',
        arguments: [code, isSelected ? 1 : 0]);
  }

  @override
  Future<void> save(PeopleEntity peopleEntity) async {
    await _peopleEntityInsertionAdapter.insert(
        peopleEntity, OnConflictStrategy.abort);
  }
}

class _$FilmsDAO extends FilmsDAO {
  _$FilmsDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _filmsEntityInsertionAdapter = InsertionAdapter(
            database,
            'films',
            (FilmsEntity item) => <String, Object?>{
                  'code': item.code,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FilmsEntity> _filmsEntityInsertionAdapter;

  @override
  Future<List<FilmsEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM films',
        mapper: (Map<String, Object?> row) => FilmsEntity(row['code'] as int?,
            row['name'] as String, (row['isSelected'] as int) != 0));
  }

  @override
  Future<FilmsEntity?> findOne(int code) async {
    return _queryAdapter.query('SELECT * FROM films WHERE code = ?1',
        mapper: (Map<String, Object?> row) => FilmsEntity(row['code'] as int?,
            row['name'] as String, (row['isSelected'] as int) != 0),
        arguments: [code]);
  }

  @override
  Future<FilmsEntity?> getByName(String name) async {
    return _queryAdapter.query('SELECT * FROM films WHERE name = ?1',
        mapper: (Map<String, Object?> row) => FilmsEntity(row['code'] as int?,
            row['name'] as String, (row['isSelected'] as int) != 0),
        arguments: [name]);
  }

  @override
  Future<void> columnUpdateIsSelect(int code, bool isSelected) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE films SET isSelected = ?2 WHERE code = ?1',
        arguments: [code, isSelected ? 1 : 0]);
  }

  @override
  Future<void> save(FilmsEntity peopleEntity) async {
    await _filmsEntityInsertionAdapter.insert(
        peopleEntity, OnConflictStrategy.abort);
  }
}
