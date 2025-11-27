import 'package:flutter/material.dart';

class CartSelectedScreen extends StatefulWidget {
  const CartSelectedScreen({super.key});
  @override
  State<CartSelectedScreen> createState() => _CartSelectedScreenState();
}

class _CartSelectedScreenState extends State<CartSelectedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final tr = AppLocalizations.of(context)!;

    return Center(child: Text("Cart"));
  }
}
