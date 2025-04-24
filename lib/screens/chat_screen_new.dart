import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:feather_icons/feather_icons.dart';

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
          backgroundColor: AppColors.primary, // Purple from theme
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Job Chats',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(FeatherIcons.search, color: Colors.white),
              onPressed: () {},
            ),
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
          return InkWell(
            onTap: () {
              DefaultTabController.of(context).animateTo(1);
            },
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withAlpha(20),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(10),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: getAvatarColor(index),
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.dark, // Dark color from theme
                              ),
                            ),
                            Text(
                              conversation['time'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
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
                                style: TextStyle(
                                  color:
                                      conversation['unread'] > 0
                                          ? AppColors.dark // Dark color from theme
                                          : Colors.grey,
                                  fontWeight:
                                      conversation['unread'] > 0
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (conversation['unread'] > 0)
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color:
                                      index == 0
                                          ? AppColors.primary // Purple
                                          : AppColors.accent, // Green
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
            ),
          );
        },
      ),
    );
  }

  Color getAvatarColor(int index) {
    switch (index) {
      case 0:
        return AppColors.primary; // Purple
      case 1:
        return AppColors.accent; // Green
      case 2:
        return AppColors.dark; // Dark
      case 3:
        return AppColors.primary; // Purple again
      case 4:
        return AppColors.accent; // Green again
      default:
        return AppColors.dark; // Dark
    }
  }

  Widget _buildChatView() {
    return Column(
      children: [
        // Messages
        Expanded(
          child: Container(
            color: Colors.white,
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
                color: Colors.black.withAlpha(20),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(FeatherIcons.image),
                  color: AppColors.primary, // Purple
                  onPressed: () {},
                  iconSize: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.primary.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(
                      color: AppColors.dark, // Dark color from theme
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.grey),
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
                  color: AppColors.accent, // Green from theme
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withAlpha(80),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(FeatherIcons.send),
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
          color:
              isMe
                  ? AppColors.primary // Purple for sent messages
                  : Colors.white,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: isMe ? const Radius.circular(4) : null,
            bottomLeft: !isMe ? const Radius.circular(4) : null,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 3,
              offset: const Offset(0, 1),
              spreadRadius: 0.5,
            ),
          ],
          border:
              !isMe
                  ? Border.all(color: AppColors.primary.withAlpha(20), width: 1)
                  : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: TextStyle(
                color: isMe ? Colors.white : AppColors.dark,
                height: 1.4,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message['time'],
                  style: TextStyle(
                    color: isMe ? Colors.white.withAlpha(180) : Colors.grey,
                    fontSize: 12,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    FeatherIcons.check,
                    size: 12,
                    color: Colors.white.withAlpha(180),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
