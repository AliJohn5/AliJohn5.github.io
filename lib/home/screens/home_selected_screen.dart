import 'package:flutter/material.dart';

class HomeSelectedScreen extends StatefulWidget {
  const HomeSelectedScreen({super.key});
  @override
  State<HomeSelectedScreen> createState() => _HomeSelectedScreenState();
}

class _HomeSelectedScreenState extends State<HomeSelectedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final tr = AppLocalizations.of(context)!;

    return Center(child: Text("Home"));
  }
}
