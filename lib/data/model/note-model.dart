import '../../resource/constants.dart';

class NoteModel
{
  int ?id ;
  String ? note , content , time , date ;

  NoteModel({this.id, this.note, this.content, this.time, this.date});

 toMap() {
    return {
      columnId: id,
      columnNote: note,
      columnContent: content,
      columnTime: time,
      columnDate: date,
    };
  }

  NoteModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
      id =  map[columnId];
      note =  map[columnNote] ;
      content =  map[columnContent] ;
      time =  map[columnTime] ;
      date =  map[columnDate]  ;

  }


}