import 'chat_message.dart';

class ChatConversation {
  final String id;
  final String userName;
  final String userAvatar;
  final List<ChatMessage> messages;
  final int unreadCount;
  final bool isOnline;
  final DateTime lastMessageTime;

  ChatConversation({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.messages,
    this.unreadCount = 0,
    this.isOnline = false,
    required this.lastMessageTime,
  });

  String get lastMessage {
    if (messages.isEmpty) return 'No messages yet';
    return messages.last.text;
  }

  ChatConversation copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    List<ChatMessage>? messages,
    int? unreadCount,
    bool? isOnline,
    DateTime? lastMessageTime,
  }) {
    return ChatConversation(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      messages: messages ?? this.messages,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }
}
