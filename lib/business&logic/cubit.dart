import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';
import 'package:todolist/business&logic/states.dart';

import '../data/local-data/sqlite.dart';
import '../data/model/note-model.dart';

class NewCubit extends Cubit<NewStates>
{
  NewCubit() : super(IntiState());

  static NewCubit get (context)=>BlocProvider.of(context)  ;

  insertNoteInDataBase(NoteModel note)async {
    var dbHelper = DataBaseHelper.dataBaseHelper ;
    await dbHelper.insertNote(note);
    noteModel = [] ;
    getAllData() ;
    emit(InsertDataSuccess());
  }

  updateNoteInDataBase(NoteModel note)async
  {
    var dbHelper = DataBaseHelper.dataBaseHelper ;
    await dbHelper.updateNote(note) ;
    noteModel = [] ;
    getAllData() ;
    emit(UpdateNote()) ;
  }


 deleteNoteInDataBase(int index) async {
   var dbHelper = DataBaseHelper.dataBaseHelper ;
   await dbHelper.deleteNote(index) ;
   noteModel = [] ;
   getAllData() ;
   emit(DeleteNote()) ;
  }

  List <NoteModel> noteModel = [] ;
  getAllData()async {
    var dbHelper = DataBaseHelper.dataBaseHelper;
    noteModel = (await dbHelper.getAllUser())!  ;
    emit(GetAllUserSuccess()) ;
  }
}