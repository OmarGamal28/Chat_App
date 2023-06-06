import 'package:bloc/bloc.dart';
import 'package:chatapp/Models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/app_constants.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(messageCollection);

  void sent({
    required String message,
    required String email,
  }) {
    messages.add({
      'message': message,
      'created at': DateTime.now(),
      'id': email,
    });
  }
  void getMessage(){

    messages.orderBy('created at',descending: true).snapshots().listen((event) {
      List<Message> messagesList=[];
      for(var doc in event.docs){
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    }) ;
  }
}
