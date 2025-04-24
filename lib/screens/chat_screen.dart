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
      'name': 'Tech Solutions',
      'lastMessage': 'When can you start the project?',
      'time': '10:30 AM',
      'unread': 2,
      'avatar': 'TS',
      'color': AppColors.primary,
    },
    {
      'name': 'Web Experts',
      'lastMessage': 'Your application has been received',
      'time': 'Yesterday',
      'unread': 0,
      'avatar': 'WE',
      'color': AppColors.moroccanBlue,
    },
    {
      'name': 'Marketing Pro',
      'lastMessage': 'We would like to schedule an interview',
      'time': 'Yesterday',
      'unread': 1,
      'avatar': 'MP',
      'color': AppColors.moroccanRed,
    },
    {
      'name': 'App Innovators',
      'lastMessage': 'Thank you for your interest',
      'time': 'Jul 28',
      'unread': 0,
      'avatar': 'AI',
      'color': AppColors.moroccanGreen,
    },
    {
      'name': 'Data Insights',
      'lastMessage': 'Your profile matches our requirements',
      'time': 'Jul 27',
      'unread': 0,
      'avatar': 'DI',
      'color': AppColors.moroccanYellow,
    },
  ];

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! We reviewed your application for the UI/UX Designer position.',
      'isMe': false,
      'time': '10:00 AM',
    },
    {
      'text': 'Your portfolio looks impressive!',
      'isMe': false,
      'time': '10:01 AM',
    },
    {
      'text': 'Thank you! I\'m very interested in this position.',
      'isMe': true,
      'time': '10:05 AM',
    },
    {
      'text': 'When can you start the project?',
      'isMe': false,
      'time': '10:10 AM',
    },
    {
      'text': 'I can start as early as next week.',
      'isMe': true,
      'time': '10:15 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.dark,
        appBar: AppBar(
          backgroundColor: const Color(0xFF2A2D30),
          foregroundColor: Colors.white,
          title: const Text('Messages'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Conversations'),
              Tab(text: 'Tech Solutions'),
            ],
            labelColor: AppColors.accent,
            unselectedLabelColor: Colors.white70,
            indicatorColor: AppColors.accent,
          ),
        ),
        body: TabBarView(
          children: [
            _buildConversationsList(),
            _buildChatView(),
          ],
        ),
      ),
    );
  }

  Widget _buildConversationsList() {
    return Container(
      color: AppColors.dark,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _conversations.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final conversation = _conversations[index];
          return CustomCard(
            elevation: 1,
            borderRadius: 12,
            backgroundColor: const Color(0xFF2A2D30),
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
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            conversation['time'],
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white70,
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
                                color: conversation['unread'] > 0
                                    ? Colors.white
                                    : Colors.white70,
                                fontWeight: conversation['unread'] > 0
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
                                color: AppColors.accent,
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
            color: const Color(0xFF2A2D30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary,
                child: Text(
                  'TS',
                  style: TextStyle(
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
                    Text(
                      'Tech Solutions',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
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
                          'Online',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.phone),
                color: AppColors.accent,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.videocam),
                color: AppColors.accent,
                onPressed: () {},
              ),
            ],
          ),
        ),
        
        // Messages
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.dark,
              image: DecorationImage(
                image: AssetImage('assets/images/chat_background.png'),
                fit: BoxFit.cover,
                opacity: 0.05,
              ),
            ),
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
            color: const Color(0xFF2A2D30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file),
                color: AppColors.accent,
                onPressed: () {},
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.white60),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
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
                          'time': '${DateTime.now().hour}:${DateTime.now().minute}',
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
    return Align(
      alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message['isMe'] ? AppColors.accent : const Color(0xFF2A2D30),
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: message['isMe'] ? const Radius.circular(0) : null,
            bottomLeft: !message['isMe'] ? const Radius.circular(0) : null,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message['time'],
              style: AppTextStyles.caption.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
