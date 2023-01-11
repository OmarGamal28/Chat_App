import 'package:chatapp/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../core/app_constants.dart';
import '../component/login_page_component.dart';

class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

   GlobalKey<FormState> formKey = GlobalKey();

   bool isLoading = false;
  //flutter.compileSdkVersion

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading ,
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: ListView(
            children: [
              const SizedBox(height: 60,),
              Image.asset('assets/images/scholar.png',height: 100.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:const [Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontFamily:'pacifico',
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
                onChanged: (data)
                  {
                    email = data;


                  }
              ),
              textFormField(
                  lable: 'Password',
                obscure: true,

                onChanged: (data){
                    password = data;
                }
              ),
            defaultMaterialButton(text: 'REGISTER',

                function: ()async
                {
                  if(formKey.currentState!.validate())
                  {
                    isLoading = true;
                    setState(() {
                    });
                    try {
                  await registerUser();
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return  ChatPage(email: email!,);
                  },),);
                  } on FirebaseAuthException catch (e)
                  {
                    if (e.code == 'weak-password')
                    {
                      showSnackBar(context,'weak password',Colors.red);
                    } else if (e.code == 'email-already-in-use')
                    {
                      showSnackBar(context,'email-already-in-use',Colors.red);
                    }
                  }
                  isLoading = false;
                  setState(() {

                  });

                  }},),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text(
                    'already have an account?',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  TextButton(onPressed: (){
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
}


  Future<void> registerUser() async {
     UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
