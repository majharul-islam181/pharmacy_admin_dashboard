import 'package:flutter/material.dart';
import '../model/chat_conversation.dart';
import '../model/chat_message.dart';

class ChatViewModel extends ChangeNotifier {
  List<ChatConversation> _conversations = [];
  ChatConversation? _selectedConversation;
  bool _isChatOpen = false;
  int _messageIdCounter = 100;

  List<ChatConversation> get conversations => _conversations;
  ChatConversation? get selectedConversation => _selectedConversation;
  bool get isChatOpen => _isChatOpen;

  ChatViewModel() {
    _initMockData();
  }

  void _initMockData() {
    final now = DateTime.now();
    _conversations = [
      ChatConversation(
        id: '1',
        userName: 'Dr. Sarah Williams',
        userAvatar: 'SW',
        isOnline: true,
        lastMessageTime: now.subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        messages: [
          ChatMessage(
            id: '1',
            text: 'Hi! I need to check the inventory status',
            isMe: false,
            timestamp: now.subtract(const Duration(minutes: 10)),
          ),
          ChatMessage(
            id: '2',
            text: 'Sure, let me pull up the latest report',
            isMe: true,
            timestamp: now.subtract(const Duration(minutes: 8)),
          ),
          ChatMessage(
            id: '3',
            text: 'Thanks! Also, can we discuss the new supplier?',
            isMe: false,
            timestamp: now.subtract(const Duration(minutes: 5)),
            isRead: false,
          ),
        ],
      ),
      ChatConversation(
        id: '2',
        userName: 'John Mitchell',
        userAvatar: 'JM',
        isOnline: false,
        lastMessageTime: now.subtract(const Duration(hours: 2)),
        unreadCount: 0,
        messages: [
          ChatMessage(
            id: '4',
            text: 'The shipment arrived today',
            isMe: false,
            timestamp: now.subtract(const Duration(hours: 3)),
          ),
          ChatMessage(
            id: '5',
            text: 'Great! Please update the stock records',
            isMe: true,
            timestamp: now.subtract(const Duration(hours: 2)),
          ),
        ],
      ),
      ChatConversation(
        id: '3',
        userName: 'Emma Thompson',
        userAvatar: 'ET',
        isOnline: true,
        lastMessageTime: now.subtract(const Duration(hours: 5)),
        unreadCount: 1,
        messages: [
          ChatMessage(
            id: '6',
            text: 'Do we have paracetamol in stock?',
            isMe: false,
            timestamp: now.subtract(const Duration(hours: 5)),
            isRead: false,
          ),
        ],
      ),
      ChatConversation(
        id: '4',
        userName: 'Michael Brown',
        userAvatar: 'MB',
        isOnline: false,
        lastMessageTime: now.subtract(const Duration(days: 1)),
        unreadCount: 0,
        messages: [
          ChatMessage(
            id: '7',
            text: 'Monthly report is ready for review',
            isMe: false,
            timestamp: now.subtract(const Duration(days: 1, hours: 2)),
          ),
          ChatMessage(
            id: '8',
            text: 'I\'ll check it this evening, thank you',
            isMe: true,
            timestamp: now.subtract(const Duration(days: 1)),
          ),
        ],
      ),
      ChatConversation(
        id: '5',
        userName: 'Lisa Anderson',
        userAvatar: 'LA',
        isOnline: true,
        lastMessageTime: now.subtract(const Duration(days: 2)),
        unreadCount: 0,
        messages: [
          ChatMessage(
            id: '9',
            text: 'Can we schedule a meeting next week?',
            isMe: false,
            timestamp: now.subtract(const Duration(days: 2, hours: 5)),
          ),
          ChatMessage(
            id: '10',
            text: 'Yes, Tuesday afternoon works for me',
            isMe: true,
            timestamp: now.subtract(const Duration(days: 2)),
          ),
        ],
      ),
    ];
  }

  void selectConversation(String id) {
    _selectedConversation = _conversations.firstWhere((c) => c.id == id);
    _isChatOpen = true;

    // Mark messages as read
    if (_selectedConversation!.unreadCount > 0) {
      final updatedMessages = _selectedConversation!.messages.map((msg) {
        if (!msg.isMe && !msg.isRead) {
          return msg.copyWith(isRead: true);
        }
        return msg;
      }).toList();

      final index = _conversations.indexWhere((c) => c.id == id);
      _conversations[index] = _selectedConversation!.copyWith(
        messages: updatedMessages,
        unreadCount: 0,
      );
      _selectedConversation = _conversations[index];
    }

    notifyListeners();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty || _selectedConversation == null) return;

    final newMessage = ChatMessage(
      id: '${_messageIdCounter++}',
      text: text.trim(),
      isMe: true,
      timestamp: DateTime.now(),
      isRead: true,
    );

    final updatedMessages = [
      ..._selectedConversation!.messages,
      newMessage,
    ];

    final index =
        _conversations.indexWhere((c) => c.id == _selectedConversation!.id);
    _conversations[index] = _selectedConversation!.copyWith(
      messages: updatedMessages,
      lastMessageTime: DateTime.now(),
    );

    _selectedConversation = _conversations[index];

    // Move conversation to top
    final conversation = _conversations.removeAt(index);
    _conversations.insert(0, conversation);

    notifyListeners();
  }

  void goBackToChatList() {
    _isChatOpen = false;
    notifyListeners();
  }

  void clearSelectedConversation() {
    _selectedConversation = null;
    _isChatOpen = false;
    notifyListeners();
  }
}
