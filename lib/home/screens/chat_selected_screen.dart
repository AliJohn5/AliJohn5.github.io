import 'package:flutter/material.dart';

class ChatSelectedScreen extends StatefulWidget {
  const ChatSelectedScreen({super.key});
  @override
  State<ChatSelectedScreen> createState() => _ChatSelectedScreenState();
}

class _ChatSelectedScreenState extends State<ChatSelectedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final tr = AppLocalizations.of(context)!;

    return Center(child: Text("Chat"));
  }
}
