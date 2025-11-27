import 'package:flutter/material.dart';

class NotificationsSelectedScreen extends StatefulWidget {
  const NotificationsSelectedScreen({super.key});
  @override
  State<NotificationsSelectedScreen> createState() => _NotificationsSelectedScreenState();
}

class _NotificationsSelectedScreenState extends State<NotificationsSelectedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final tr = AppLocalizations.of(context)!;

    return Center(child: Text("Notification"));
  }
}
