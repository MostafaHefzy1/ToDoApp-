import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/model/note-model.dart';
import 'package:todolist/presentation/todolist.dart';

import 'business&logic/bloc-observer.dart';
import 'business&logic/cubit.dart';
import 'data/local-data/sqlite.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(() {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:
      [
          BlocProvider<NewCubit>(create: (BuildContext context) => NewCubit()..getAllData()
          ) ,
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home:ToDoList(NoteModel()),
        theme: ThemeData(
          primarySwatch:Colors.grey ,

        ),
    ),
    );
  }
}


