import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/presentation/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatapp/presentation/pages/cubits/login_cubit/login_cubit.dart';
import 'package:chatapp/presentation/pages/cubits/register_cubit/register_cubit.dart';
import 'package:chatapp/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context)=> LoginCubit()),
        BlocProvider(create: (context)=> RegisterCubit()),
        BlocProvider(create: (context)=> ChatCubit()),





      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Chat App',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:  LoginPage(),
      ),
    );
  }
}


