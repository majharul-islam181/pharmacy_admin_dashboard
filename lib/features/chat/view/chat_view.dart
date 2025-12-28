import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/chat_view_model.dart';
import 'widgets/conversation_list.dart';
import 'widgets/chat_header.dart';
import 'widgets/message_list.dart';
import 'widgets/chat_input_field.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final viewModel = context.watch<ChatViewModel>();

        if (isMobile) {
          return _buildMobileLayout(context, viewModel);
        } else {
          return _buildDesktopLayout(context, viewModel);
        }
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, ChatViewModel viewModel) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child,
        );
      },
      child: viewModel.isChatOpen && viewModel.selectedConversation != null
          ? _buildChatPanel(
              context,
              viewModel,
              isMobile: true,
            )
          : const ConversationList(),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ChatViewModel viewModel) {
    return Row(
      children: [
        // Left panel - Conversation List
        const SizedBox(
          width: 360,
          child: ConversationList(),
        ),
        // Right panel - Chat
        Expanded(
          child: viewModel.selectedConversation != null
              ? _buildChatPanel(context, viewModel)
              : _buildEmptyState(),
        ),
      ],
    );
  }

  Widget _buildChatPanel(
    BuildContext context,
    ChatViewModel viewModel, {
    bool isMobile = false,
  }) {
    final conversation = viewModel.selectedConversation!;

    return Container(
      key: ValueKey(conversation.id),
      color: Colors.white,
      child: Column(
        children: [
          ChatHeader(
            userName: conversation.userName,
            userAvatar: conversation.userAvatar,
            isOnline: conversation.isOnline,
            onBackPressed: isMobile ? viewModel.goBackToChatList : null,
          ),
          Expanded(
            child: MessageList(messages: conversation.messages),
          ),
          ChatInputField(
            onSend: viewModel.sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      color: const Color(0xFFFAFAFA),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Color(0xFFE5E7EB),
            ),
            SizedBox(height: 16),
            Text(
              'Select a conversation to start chatting',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
