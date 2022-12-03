import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../resource/constants.dart';
import '../model/note-model.dart';

class DataBaseHelper{

  DataBaseHelper._();
  static final DataBaseHelper dataBaseHelper =   DataBaseHelper._();

  static Database ?_database  ;
  Future<Database?> get database async {
    if (_database == null){
      _database  = await intialDb() ;
      return _database ;
    }else {
      return _database ;
    }
  }

  intialDb() async {
    String path = join(await getDatabasesPath()  , databaseName) ;
    Database database = await openDatabase(path , onCreate: _onCreate , version:1) ;
    return database ;
  }

  _onCreate(Database database , int version) async {
    await database.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
        $columnNote TEXT NOT NULL , 
        $columnContent TEXT NOT NULL  , 
        $columnTime TEXT NOT NULL  , 
        $columnDate TEXT NOT NULL 
      )
     ''') ;
    print(" onCreate =====================================") ;

  }


  Future<void> insertNote(NoteModel note) async {
    var dbClient = await database;
    await dbClient
        ?.insert(tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      print('insert is success');
    }).catchError((error) {
      print('insert is Failed');
      print(error.toString());
    });
  }

  updateNote(NoteModel note)async {
    var ClientDB = await database ;
    ClientDB?.update(tableName, note.toMap() ,
        where: '$columnId=?' ,
        whereArgs: [note.id]
    ).then((value) {
      print('Update Success') ;
    });
  }

  Future<int?> deleteNote(int id)async {
    var ClientDB = await database ;
    return await ClientDB?.delete(tableName,where: '$columnId=?' , whereArgs: [id]).then((value){
      print('Delete Success') ;
    }) ;
  }

  Future<List<NoteModel>?>getAllUser()async {
    var ClientDB = await database ;
    List<Map<String, dynamic>>?maps   = await ClientDB?.query(tableName);
    print('maps is length ');
    print(maps?.length) ;
    return maps!.isNotEmpty ? maps.map((user) => NoteModel.fromJson(user)).toList() : [] ;
  }
}
