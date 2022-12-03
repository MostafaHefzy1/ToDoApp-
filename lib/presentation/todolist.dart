import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/business&logic/cubit.dart';
import 'package:todolist/business&logic/states.dart';
import '../data/model/note-model.dart';
import 'add-note.dart';

class ToDoList extends StatelessWidget
{
  NoteModel model ;

  ToDoList(this.model) ;

  @override
  Widget build(BuildContext context) {
    var cubit  = NewCubit.get(context) ;
    return BlocConsumer<NewCubit, NewStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>AddNote
                        (
                        NoteModel(
                          date: '' ,
                          time:  '' ,
                          content: '',
                          note: '',
                        ) ,
                      ))) ;
                    }, icon: Icon(Icons.edit))
              ],
            ),
            body:cubit.noteModel.isNotEmpty ?  ListView.separated(
              itemBuilder: (context , index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children:
                      [
                        CircleAvatar(
                          radius: 45,
                          child: Column(
                            children:
                            [
                              SizedBox(
                                height: 15,
                              ) ,
                              Text(
                                '${cubit.noteModel[index].time}' ,

                                style: TextStyle(
                                  // backgroundColor: Colors.black12,
                                    fontSize: 20,
                                    color: Colors.blueGrey
                                ),

                              ) ,
                              SizedBox(
                                height: 5,
                              ) ,

                              Text(
                                '${cubit.noteModel[index].date}' ,

                                style: TextStyle(
                                    fontSize: 16,

                                    color: Colors.lightBlueAccent
                                ),)
                            ],
                          ),
                          backgroundColor:Colors.black12,

                        ),
                        SizedBox(
                          width: 25,
                        ) ,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Text(
                                '${cubit.noteModel[index].note}' ,
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20 ,

                                  fontWeight: FontWeight.w600 ,

                                ),
                                maxLines: 1,
                              ) ,
                              Text(
                                '${cubit.noteModel[index].content}' ,
                                style: TextStyle(
                                  fontSize: 16 ,
                                ),
                                maxLines: 3  ,
                                overflow: TextOverflow.ellipsis,
                              ) ,
                            ],
                          ),
                        ),
                        Spacer(),
                        Column(
                          children:
                          [
                            IconButton(
                              onPressed: ()
                              {
                                cubit.deleteNoteInDataBase(cubit.noteModel[index].id!) ;
                              },
                              icon: Icon(
                                Icons.delete ,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ) ,
                            IconButton(
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>AddNote
                                  (
                                  NoteModel(
                                    date: cubit.noteModel[index].date.toString() ,
                                    time: cubit.noteModel[index].time.toString(),
                                    content: cubit.noteModel[index].content.toString() ,
                                    note: cubit.noteModel[index].note .toString() ,
                                    id:cubit.noteModel[index].id
                                  ) ,
                                ))) ;

                              },
                              icon: Icon(
                                Icons.edit ,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ) ,
              itemCount: cubit.noteModel.length,
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    '-----------------------------------------------------------------------------------------'),
              ),

            )  :  Padding(
              padding: const EdgeInsets.only(
                  left:   20.0 ,
                  right: 20 ,
                  top: 80
              ),
              child: Center(
                child: Column(
                  children:
                  [
                    Image(image: AssetImage(
                        'assets/images/note-image.jpeg'
                    ))  ,
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ADD A NEW NOTES' ,
                      style: TextStyle(
                          fontSize: 24  ,
                          fontWeight: FontWeight.bold ,
                          color: Colors.black54
                      ),

                    ) ,
                  ],
                ),
              ),
            )   ,



            ) ;

        }
    );
  }

}




