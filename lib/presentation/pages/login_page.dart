import 'package:chatapp/presentation/pages/chat_page.dart';

import '../component/login_page_component.dart';
import 'package:chatapp/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import '../../core/app_constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginPage extends StatefulWidget {
   const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  String? email;

  String? password;

  @override
  Widget build(BuildContext context){
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 60,),//لو انا مش عارف المساحهه
              Image.asset('assets/images/scholar.png',height: 100.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontFamily:'pacifico',
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
                onChanged: (data){
                    email = data;
                }
              ),
              textFormField(
                obscure: true,
                  lable: 'Password',
                onChanged: (data){
                    password = data;
                }
              ),
              defaultMaterialButton(
                  text: 'LOGIN',
                function: () async{
                    if(formKey.currentState!.validate()){
                      isLoading = true;
                      setState(() {

                      });
                      try {
                        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(email: email!,),),);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context,'user-not-found',Colors.red);
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,'wrong-password',Colors.red);
                        }
                      }
                      isLoading = false;
                      setState(() {

                      });
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
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
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
    );
  }
}
