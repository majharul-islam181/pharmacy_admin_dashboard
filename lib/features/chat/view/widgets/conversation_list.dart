import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../view_model/chat_view_model.dart';
import 'conversation_tile.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatViewModel>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search, size: 20),
                  onPressed: () {},
                  color: const Color(0xFF6B7280),
                ),
              ],
            ),
          ),
          // Conversation List
          Expanded(
            child: viewModel.conversations.isEmpty
                ? const Center(
                    child: Text(
                      'No conversations yet',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: viewModel.conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = viewModel.conversations[index];
                      final isSelected =
                          viewModel.selectedConversation?.id == conversation.id;

                      return ConversationTile(
                        conversation: conversation,
                        isSelected: isSelected,
                        onTap: () =>
                            viewModel.selectConversation(conversation.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
