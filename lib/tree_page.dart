import 'package:flutter/material.dart';

class TreePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상단 노치 영역', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '현재 내 포인트: 0p',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // 상단 여백
          Text(
            '내 나무',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // 상태바
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: LinearProgressIndicator(
              value: 0.0, // 0 ~ 1 사이 값으로 설정
              color: Color(0xFF67EACA),
              backgroundColor: Colors.grey.shade300,
              minHeight: 10,
            ),
          ),
          SizedBox(height: 20),
          // 텍스트 박스
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFFFCF9EC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '응애 나 씨앗',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          // 씨앗 이미지
          Image.asset(
            'assets/seed.png', // assets 폴더에 씨앗 이미지를 추가해야 합니다.
            height: 150,
          ),
          Spacer(),
          // 하단 버튼들
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  label: '물주기',
                  points: '10p',
                  icon: Icons.water_drop,
                ),
                ActionButton(
                  label: '햇빛쐬기',
                  points: '20p',
                  icon: Icons.wb_sunny,
                ),
                ActionButton(
                  label: '비료주기',
                  points: '50p',
                  icon: Icons.grass,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final String points;
  final IconData icon;

  const ActionButton({
    Key? key,
    required this.label,
    required this.points,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF67EACA)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(icon, size: 30, color: Color(0xFF67EACA)),
              SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                points,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFB0F4E6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
