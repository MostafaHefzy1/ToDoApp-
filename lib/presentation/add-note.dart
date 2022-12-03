import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../business&logic/cubit.dart';
import '../business&logic/states.dart';
import '../data/model/note-model.dart';
class AddNote extends StatelessWidget
{
  NoteModel model ;

  AddNote(this.model) ;

  @override
  Widget build(BuildContext context)  {
    return BlocConsumer<NewCubit,NewStates>(
    listener: (context, state)
    {},
    builder: (context, state)
    {


      var formKey = GlobalKey<FormState>();

      var noteControl = TextEditingController() ;
      var contentControl = TextEditingController() ;
      var cubit = NewCubit.get(context);


      return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: ()
              {
                if(model.time==''&&model.date=='')
                {
                  if(formKey.currentState!.validate()) {
                    cubit.insertNoteInDataBase(NoteModel(
                      note: noteControl.text ,
                      content: contentControl.text ,
                      time:TimeOfDay.now().format(context).substring(0 , 7).toString(),
                      date:DateTime.now().toString().substring(0 , 10 ).toString(),
                    )) ;
                    Navigator.pop(context) ;
                  }
                }
                else
                {
                  cubit.updateNoteInDataBase(NoteModel(
                    time:TimeOfDay.now().format(context).substring(0 , 7).toString(),
                    date:DateTime.now().toString().substring(0 , 10 ).toString(),
                    note: noteControl.text.toString() == '' ? model.note : noteControl.text ,
                    content:  contentControl.text.toString() == '' ? model.content : contentControl.text ,
                    id: model.id

                  ));
                  Navigator.pop(context) ;
                }
              }, icon: Icon(Icons.save)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:model.time==''&&model.date=='' ? Column(
              children:
              [
                  TextFormField(
                    validator: (content){
                      if(content!.isEmpty)
                        return 'Note cannot be empty' ;
                    },
                    decoration: InputDecoration(
                      label: Text('Note') ,
                      prefixIcon: Icon(
                        Icons.event_note_outlined,
                    ),

                    ),
                    controller: noteControl ,
                  ),
                  SizedBox(
                    height: 10,
                  ) ,
                  TextFormField(
                    validator: (content){
                      if(content!.isEmpty)
                        return 'Content cannot be empty' ;
                    },
                  decoration: InputDecoration(
                    label: Text('Content') ,
                    prefixIcon: Icon(
                      Icons.notes,
                    ),

                  ),
                  controller: noteControl ,
                ),

              ],
            ) :
            Column(
              children:
              [
                TextFormField(
                  validator: (content){
                    if(content!.isEmpty)
                      return 'Note cannot be empty' ;
                  },
                  decoration: InputDecoration(
                    label: Text('Note') ,
                    prefixIcon: Icon(
                      Icons.event_note_outlined,
                    ),

                  ),

                ),
                SizedBox(
                  height: 10,
                ) ,
                TextFormField(
                  validator: (content){
                    if(content!.isEmpty)
                      return 'Content cannot be empty' ;
                  },
                  decoration: InputDecoration(
                    label: Text('Content') ,
                    prefixIcon: Icon(
                      Icons.notes,
                    ),

                  ),
                  controller: contentControl ,
                ),

              ],
            ),
          ),
        ),
      ),
      )  ;
    }
    ) ;
    }
}
