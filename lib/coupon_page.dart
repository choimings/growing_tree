import 'package:flutter/material.dart';

class CouponPage extends StatelessWidget {
  final int couponCount;

  const CouponPage({Key? key, required this.couponCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 쿠폰함'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "보유한 쿠폰: $couponCount개",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
