import 'package:flutter/material.dart';

class ProfileSelectedScreen extends StatefulWidget {
  const ProfileSelectedScreen({super.key});
  @override
  State<ProfileSelectedScreen> createState() => _ProfileSelectedScreenState();
}

class _ProfileSelectedScreenState extends State<ProfileSelectedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final tr = AppLocalizations.of(context)!;

    return Center(child: Text("Profile"));
  }
}
