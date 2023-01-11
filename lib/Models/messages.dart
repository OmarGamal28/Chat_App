class Message {
  final String message;
  final String id;

  Message(this.message, this.id);
  factory Message.fromJson(jsonData)=> Message(
    jsonData['message'],jsonData['id']
  );
}