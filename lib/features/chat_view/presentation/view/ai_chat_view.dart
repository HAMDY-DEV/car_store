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
  final String message;
  final String sender;
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

  static const String apiKey =
      'AIzaSyCH6nQVDrzqiypqUEUfOIen5zbQOjLLDrA'; // Replace with your API key
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);

  String text = 'قل لي مرحبأ بك في تطبيق Car Store رساله قصيره';

  bool show = false;

  @override
  void initState() {
    super.initState();
    sendMessages(text);
  }

  void sendMessages(String text) async {
    try {
      final content = [Content.text(text)];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(
          ModelMessage(
            message: response.text ?? 'No response from AI.',
            sender: 'ai',
            time: DateTime.now(),
          ),
        );
        _scrollToBottom(); // Ensure we scroll to the bottom
      });
    } catch (e) {
      // You might want to handle the error or notify the user
    }
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add(ModelMessage(
        message: message,
        sender: 'user',
        time: DateTime.now(),
      ));
      _scrollToBottom(); // Scroll to bottom when a new message is added
    });

    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(
          ModelMessage(
            message: response.text ?? 'No response from AI.',
            sender: 'ai',
            time: DateTime.now(),
          ),
        );
        _scrollToBottom(); // Ensure we scroll to the bottom
      });
    } catch (e) {
      // You might want to handle the error or notify the user
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Row(
          children: [
            LottieBuilder.asset(
              'assets/json/aicht.json',
              fit: BoxFit.cover,
              width: 80.w,
              height: 80.h,
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
                      Positioned(
                        left: 10,
                        bottom: 10,
                        right: 10,
                        top: 10,
                        child: LottieBuilder.asset(
                          'assets/json/chat_ai_body.json',
                          width: 100.w,
                          height: 100.h,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: LottieBuilder.asset(
                          'assets/json/chat_loding.json',
                          fit: BoxFit.cover,
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      ListView.builder(
                        itemCount: _messages.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final message = _messages[index];

                          show = false;

                          return BubbleSpecialOne(
                            text: message.message,
                            isSender: message.sender == 'user',
                            color: AppColors.primaryColor,
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              color: AppColors.whiteColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      show
                          ? Positioned(
                              left: 10,
                              bottom: 10,
                              child: LottieBuilder.asset(
                                'assets/json/chat_loding.json',
                                fit: BoxFit.cover,
                                width: 30.w,
                                height: 30.h,
                              ),
                            )
                          : Container(),
                    ],
                  ),
          ),
          MessageBar(
            onSend: (message) {
              sendMessage(message);
              setState(() {
                show = true;
              });
            },
          ),
        ],
      ),
    );
  }
}
