import 'package:chatapp/presentation/pages/chat_page.dart';
import 'package:chatapp/presentation/pages/cubits/login_cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/login_page_component.dart';
import 'package:chatapp/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import '../../core/app_constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'cubits/login_cubit/login_state.dart';


class LoginPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginLoading){
          isLoading = true;
        }else if(state is LoginSuccess){
          Navigator.push(context, MaterialPageRoute(builder: (
              context) => ChatPage(email: email!,),),);
          isLoading = false;


        }else if(state is LoginError){
          showSnackBar(context, state.error,Colors.white12);
          isLoading = false;


        }
      },
      builder:(context,state)=> ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 60,), //لو انا مش عارف المساحهه
                Image.asset('assets/images/scholar.png', height: 100.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontFamily: 'pacifico',
                          fontSize: 32,
                          color: Colors.white
                      ),

                    ),
                  ],
                ),
                const SizedBox(height: 60,),

                Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(

                        'LOGIN',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,

                        ),
                      ),
                    ],
                  ),
                ),
                textFormField(
                    lable: 'Email',
                    obscure: false,
                    onChanged: (data) {
                      email = data;
                    }
                ),
                textFormField(
                    obscure: true,
                    lable: 'Password',
                    onChanged: (data) {
                      password = data;
                    }
                ),
                defaultMaterialButton(
                    text: 'LOGIN',
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).loginUser(email: email!, password: password!);
                      }
                    }

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      'dont have an account sign up',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) {
                        return RegisterPage();
                      }));
                    },
                        child: const Text(
                            'Register'
                        ))
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
