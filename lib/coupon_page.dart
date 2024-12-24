import 'package:flutter/material.dart';

class CouponPage extends StatelessWidget {
  final int couponCount; // 쿠폰 개수
  final List<String> myCoupons; // 쿠폰 리스트

  const CouponPage({
    Key? key,
    required this.couponCount,
    required this.myCoupons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("내 쿠폰함"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: couponCount, // 저장된 쿠폰 개수
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myCoupons[index]), // 쿠폰 이름 출력
          );
        },
      ),
    );
  }
}
