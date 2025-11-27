import 'package:flutter/material.dart';

class SearchSelectedScreen extends StatefulWidget {
  const SearchSelectedScreen({super.key});
  @override
  State<SearchSelectedScreen> createState() => _SearchSelectedScreenState();
}

class _SearchSelectedScreenState extends State<SearchSelectedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final tr = AppLocalizations.of(context)!;

    return Center(child: Text("Search"));
  }
}
