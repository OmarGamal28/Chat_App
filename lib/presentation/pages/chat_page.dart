import 'package:chatapp/Models/messages.dart';
import 'package:chatapp/core/app_constants.dart';
import 'package:chatapp/presentation/component/chat_page_component.dart';
import 'package:chatapp/presentation/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/chat_cubit/chat_state.dart';

class ChatPage extends StatelessWidget {
  CollectionReference messages =
  FirebaseFirestore.instance.collection(messageCollection);
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  final String email;
  List<Message> messageList = [];

  ChatPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logo,
                height: 50.0,
              ),
              Text('Scholar Chat')
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context,state){
                if (state is ChatSuccess){
                  messageList =state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? chatBubble(message: messageList[index])
                          : chatBubbleForFriend(message: messageList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: controller,
              onFieldSubmitted: (data) {
                controller.clear();
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.send,
                    color: primaryColor,

                  ),
                  labelText: 'Send Message',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: primaryColor))),
            ),
          )
        ],
      ),
    );
  }
}
