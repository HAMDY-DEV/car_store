// lib/features/chat/view/ai_chat_view.dart
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';

class AiChatView extends StatefulWidget {
  const AiChatView({super.key});

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class ModelMessage {
  final String message; // نص الرسالة
  final String sender;  // 'user' | 'ai' | 'system'
  final DateTime time;

  ModelMessage({
    required this.message,
    required this.time,
    required this.sender,
  });
}

class _AiChatViewState extends State<AiChatView> {
  final List<ModelMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  // ✅ بناءً على طلبك، الكي داخل الكود
  static const String apiKey = 'AIzaSyCP61BzboL6kjcvhCPxjoIp6UuaFVXESsk';

  late final GenerativeModel _model;
  ChatSession? _chat; // للحفاظ على سياق المحادثة
  bool _isTyping = false;

  final String _welcomePrompt = 'قل لي مرحبًا بك في تطبيق Car Store رسالة قصيرة.';

  @override
  void initState() {
    super.initState();
    // 👇 استخدم موديل مدعوم
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    _chat = _model.startChat(history: []);
    _sendAi(_welcomePrompt, addUserBubble: false);
  }

  Future<void> _sendAi(String text, {bool addUserBubble = true}) async {
    if (!mounted) return;

    if (addUserBubble) {
      _addMessage(ModelMessage(
        message: text,
        sender: 'user',
        time: DateTime.now(),
      ));
    }

    _setTyping(true);

    try {
      final response = await _chat!.sendMessage(Content.text(text));
      final aiText = response.text?.trim();

      _addMessage(
        ModelMessage(
          message: (aiText == null || aiText.isEmpty)
              ? 'لم يصل رد من الذكاء الاصطناعي.'
              : aiText,
          sender: 'ai',
          time: DateTime.now(),
        ),
      );
    } catch (e) {
      _addMessage(ModelMessage(
        message: 'حدث خطأ أثناء الاتصال بالذكاء الاصطناعي:\n$e',
        sender: 'system',
        time: DateTime.now(),
      ));
    } finally {
      _setTyping(false);
    }
  }

  void _addMessage(ModelMessage msg) {
    if (!mounted) return;
    setState(() => _messages.add(msg));
    _scrollToBottom();
  }

  void _setTyping(bool v) {
    if (!mounted) return;
    setState(() => _isTyping = v);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color _bubbleColor(String sender) {
    if (sender == 'user') return AppColors.primaryColor;
    if (sender == 'ai') return AppColors.primaryColor.withOpacity(0.78);
    return Colors.redAccent; // system/error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Row(
          children: [
            LottieBuilder.asset(
              'assets/json/aicht.json',
              fit: BoxFit.cover,
              width: 48.w,
              height: 48.h,
            ),
            Gap(10.w),
            Text(
              'AI Chat Bot',
              style: getTitleStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 20.sp,
                context,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Stack(
                    children: [
                      Positioned.fill(
                        child: LottieBuilder.asset(
                          'assets/json/chat_ai_body.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 12.w,
                        bottom: 12.h,
                        child: LottieBuilder.asset(
                          'assets/json/chat_loding.json',
                          width: 36.w,
                          height: 36.h,
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    separatorBuilder: (_, __) => Gap(6.h),
                    itemBuilder: (context, index) {
                      if (_isTyping && index == _messages.length) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: LottieBuilder.asset(
                            'assets/json/chat_loding.json',
                            width: 36.w,
                            height: 36.h,
                          ),
                        );
                      }

                      final msg = _messages[index];
                      return BubbleSpecialOne(
                        text: msg.message,
                        isSender: msg.sender == 'user',
                        color: _bubbleColor(msg.sender),
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontStyle: msg.sender == 'system'
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
          ),
          MessageBar(
            onSend: (message) {
              if (message.trim().isEmpty) return;
              _sendAi(message);
            },
          ),
        ],
      ),
    );
  }
}
