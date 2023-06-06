import 'package:chatapp/presentation/pages/chat_page.dart';
import 'package:chatapp/presentation/pages/cubits/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../core/app_constants.dart';
import '../component/login_page_component.dart';


class RegisterPage extends StatelessWidget {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  //flutter.compileSdkVersion

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterLoading){
          isLoading = true;
        }else if(state is RegisterSuccess){
          Navigator.push(context, MaterialPageRoute(builder: (
              context) => ChatPage(email: email!,),),);
          isLoading = false;


        }else if(state is RegisterError){
          showSnackBar(context, state.error,Colors.white12);
          isLoading = false;


        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: primaryColor,
              body: ListView(
                children: [
                  const SizedBox(height: 60,),
                  Image.asset('assets/images/scholar.png', height: 100.0,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text(
                        'Scholar Chat',
                        style: TextStyle(
                            fontFamily: 'pacifico',
                            fontSize: 32,
                            color: Colors.white
                        ),

                      ),
                      ]),
                  const SizedBox(height: 60,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(

                          'REGISTER',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,

                          ),
                        ),
                      ],
                    ),
                  ),
                  textFormField(
                      obscure: false,


                      lable: 'Email',
                      onChanged: (data) {
                        email = data;
                      }
                  ),
                  textFormField(
                      lable: 'Password',
                      obscure: true,

                      onChanged: (data) {
                        password = data;
                      }
                  ),
                  defaultMaterialButton(text: 'REGISTER',

                    function: () async
                    {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<RegisterCubit>(context).registerUser(email: email!, password: password!);
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Text(
                        'already have an account?',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: const Text(
                          'Login'
                      ))
                    ],
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
