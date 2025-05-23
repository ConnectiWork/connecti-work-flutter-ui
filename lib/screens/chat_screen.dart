import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'Marrakech Café',
      'lastMessage': 'Can you start this weekend as a server?',
      'time': '10:30 AM',
      'unread': 2,
      'avatar': 'MC',
      'color': AppColors.primary,
    },
    {
      'name': 'Stadium Events',
      'lastMessage': 'Your application for event staff is received',
      'time': 'Yesterday',
      'unread': 0,
      'avatar': 'SE',
      'color': AppColors.moroccanBlue,
    },
    {
      'name': 'Casablanca Tours',
      'lastMessage': 'We need a tour guide for next Tuesday',
      'time': 'Yesterday',
      'unread': 1,
      'avatar': 'CT',
      'color': AppColors.moroccanRed,
    },
    {
      'name': 'Fez Hospitality',
      'lastMessage': 'Thank you for your interest in the hotel job',
      'time': 'Jul 28',
      'unread': 0,
      'avatar': 'FH',
      'color': AppColors.moroccanGreen,
    },
    {
      'name': 'Rabat Souvenir Shop',
      'lastMessage': 'Your profile matches our sales position',
      'time': 'Jul 27',
      'unread': 0,
      'avatar': 'RS',
      'color': AppColors.moroccanYellow,
    },
  ];

  final List<Map<String, dynamic>> _messages = [
    {
      'text':
          'Hello! We reviewed your application for the server position at our café during the World Cup.',
      'isMe': false,
      'time': '10:00 AM',
    },
    {
      'text': 'Your experience in hospitality is exactly what we need!',
      'isMe': false,
      'time': '10:01 AM',
    },
    {
      'text': 'Thank you! I\'m excited about working during the World Cup.',
      'isMe': true,
      'time': '10:05 AM',
    },
    {
      'text':
          'Can you start this weekend as a server? We have a training session.',
      'isMe': false,
      'time': '10:10 AM',
    },
    {
      'text': 'Yes, I\'m available this weekend. What time should I arrive?',
      'isMe': true,
      'time': '10:15 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Job Chats',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Conversations'),
              Tab(text: 'Marrakech Café'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
          ),
        ),
        body: TabBarView(
          children: [_buildConversationsList(), _buildChatView()],
        ),
      ),
    );
  }

  Widget _buildConversationsList() {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _conversations.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final conversation = _conversations[index];
          return CustomCard(
            elevation: 1,
            borderRadius: 12,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(12),
            onTap: () {
              DefaultTabController.of(context).animateTo(1);
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: conversation['color'],
                  child: Text(
                    conversation['avatar'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            conversation['name'],
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            conversation['time'],
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation['lastMessage'],
                              style: AppTextStyles.bodyMedium.copyWith(
                                color:
                                    conversation['unread'] > 0
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                                fontWeight:
                                    conversation['unread'] > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (conversation['unread'] > 0)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                conversation['unread'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        // Chat header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary,
                child: const Text(
                  'MC',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marrakech Café',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Hiring for World Cup 2030',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.accent.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.phone),
                  color: AppColors.accent,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        
        // Messages
        Expanded(
          child: Container(
            // Using a solid color background (green) instead of any image or pattern
            color: Color.fromRGBO(43, 179, 99, 0.05), // Light green background (AppColors.accent with 5% opacity)
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              reverse: false,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
        ),

        // Input field
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.image),
                  color: AppColors.primary,
                  onPressed: () {},
                  iconSize: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.divider, width: 1),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.greenGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.white,
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      setState(() {
                        _messages.add({
                          'text': _messageController.text,
                          'isMe': true,
                          'time':
                              '${DateTime.now().hour}:${DateTime.now().minute}',
                        });
                        _messageController.clear();
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final bool isMe = message['isMe'];

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: isMe ? const Radius.circular(4) : null,
            bottomLeft: !isMe ? const Radius.circular(4) : null,
            topLeft:
                isMe ? const Radius.circular(20) : const Radius.circular(4),
            topRight:
                !isMe ? const Radius.circular(20) : const Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 3,
              offset: const Offset(0, 1),
              spreadRadius: 0.5,
            ),
          ],
          border:
              !isMe ? Border.all(color: AppColors.divider, width: 0.5) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: AppTextStyles.bodyMedium.copyWith(
                color: isMe ? Colors.white : AppColors.textPrimary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message['time'],
                  style: AppTextStyles.caption.copyWith(
                    color: isMe ? Colors.white70 : AppColors.textSecondary,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.check, size: 12, color: Colors.white70),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
