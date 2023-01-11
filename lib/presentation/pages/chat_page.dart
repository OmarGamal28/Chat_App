import 'package:chatapp/Models/messages.dart';
import 'package:chatapp/core/app_constants.dart';
import 'package:chatapp/presentation/component/chat_page_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {

  CollectionReference messages = FirebaseFirestore.instance.collection(messageCollection);
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  final String email;

  ChatPage({super.key,required this.email});


  @override
  Widget build(BuildContext context) {
    // read data
    return StreamBuilder<QuerySnapshot>
      (
        stream: messages.orderBy('created at',descending: true).snapshots() ,
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<Message> messageList =[];
            for(int i = 0 ;i < snapshot.data!.docs.length ; i++)
            {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return  Scaffold(
              appBar: AppBar(
                  backgroundColor: primaryColor,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(logo,height: 50.0,),
                      Text('Scholar Chat')
                    ],
                  )

              ),
              body: Column(
                  children:[
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemCount: messageList.length ,
                          itemBuilder:(context,index)
                      {
                        return messageList[index].id == email ? chatBubble(
                            message: messageList[index]
                        ) : chatBubbleForFriend(message: messageList[index]);

                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: controller,

                        onFieldSubmitted:(data){
                          messages.add({
                            'message': data,
                            'created at': DateTime.now(),
                            'id': email,
                          });
                          controller.clear();
                          scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn
                          );
                        },

                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.send,color: primaryColor,),
                            labelText: 'Send Message',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: primaryColor)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: primaryColor)
                            )

                        ),

                      ),
                    )
                  ]
              ),
            );
          }else{
            return const Text('Loading..');
          }
        }
    );
  }
}
