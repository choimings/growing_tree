import 'package:flutter/material.dart';

class TreePage extends StatefulWidget {
  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  int points = 200; // 초기 포인트
  final int maxPoints = 2160; // 상태바의 최대 값
  String treeState = "씨앗"; // 나무 상태
  String message = "응애 나 씨앗"; // 상태 메시지
  String treeImage = 'assets/seed.png'; // 기본 이미지
  double progress = 0; // 상태바 게이지 (0.0 ~ 1.0)
  final List<int> levelPoints = [80, 240, 720, 2160]; // 레벨업 기준점
  int currentLevel = 0; // 현재 레벨 (0: 씨앗, 1: 새싹, 2: 나뭇가지, 3: 나무, 4: 꽃)

  // 레벨업 모달 표시
  void showLevelUpModal() {
    showDialog(
      context: context,
      barrierDismissible: false, // 모달 외부 클릭 시 닫히지 않음
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("레벨업"),
          content: Text("레벨업하시겠습니까?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                levelUp();
              },
              child: Text("레벨업하기"),
            ),
          ],
        );
      },
    );
  }

  // 레벨업 처리
  void levelUp() {
    setState(() {
      if (currentLevel < levelPoints.length) {
        currentLevel++; // 다음 레벨로 증가
        switch (currentLevel) {
          case 1:
            treeState = "새싹";
            message = "응애 나 새싹";
            treeImage = 'assets/sprout.png';
            break;
          case 2:
            treeState = "나뭇가지";
            message = "ㅎㅇ 난 나뭇가지";
            treeImage = 'assets/branch.png';
            break;
          case 3:
            treeState = "나무";
            message = "후훗 난 나무";
            treeImage = 'assets/tree.png';
            break;
          case 4:
            treeState = "꽃";
            message = "짜잔 난 꽃";
            treeImage = 'assets/flower.png';
            break;
        }
      }
    });
  }

  // 포인트 사용 및 상태바 증가
  void usePoints(int cost) {
    if (points >= cost) {
      setState(() {
        points -= cost; // 포인트 차감
        progress += cost / maxPoints; // 사용된 포인트 비율만큼 게이지 증가
        if (progress > 1.0) progress = 1.0; // 상태바 최대값 제한

        // 특정 지점에서만 레벨업 모달 표시
        if (currentLevel < levelPoints.length &&
            progress >= levelPoints[currentLevel] / maxPoints) {
          showLevelUpModal();
        }
      });
    }
  }

  // 액션 버튼을 눌렀을 때 호출되는 함수
  void handleAction(String action, int cost) {
    if (points >= cost) {
      // 포인트가 충분한 경우 확인 모달 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  action == '물주기'
                      ? 'assets/water.png'
                      : action == '햇빛쐬기'
                      ? 'assets/sun.png'
                      : 'assets/fertilizer.png',
                  height: 30,
                  width: 30,
                ),
                SizedBox(width: 10),
                Text('$action')
              ],
            ),
            content: Text("$cost 포인트를 사용해서 $action 하시겠어요?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                },
                child: Text("아니요"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                  usePoints(cost); // 포인트 사용
                },
                child: Text("네"),
              ),
            ],
          );
        },
      );
    } else {
      // 포인트가 부족한 경우 포인트 부족 모달 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 10),
                Text("포인트 부족"),
              ],
            ),
            content: Text("포인트가 부족해요. 포인트를 쌓으러 가시겠어요?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                },
                child: Text("아니요"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                  // 포인트 충전 화면으로 이동 로직 추가 가능
                },
                child: Text("네"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('상단 노치 영역', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '현재 내 포인트: ${points}p',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '내 나무',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          // 상태바
          // 상태바
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 상태바
                Stack(
                  children: [
                    // 상태바 배경
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF67EACA),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // 채워진 부분
                    FractionallySizedBox(
                      widthFactor: progress,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Color(0xFF67EACA),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10), // 상태바와 숫자 간격
                // 상태바 아래 숫자
                Container(
                  height: 30, // 숫자 영역 높이
                  child: Stack(
                    children: [
                      // 숫자 0
                      Positioned(
                        left: 0, // 상태바의 시작점
                        child: Text("0", style: TextStyle(fontSize: 12)),
                      ),
                      // 숫자 80
                      Positioned(
                        left: MediaQuery.of(context).size.width * (80 / maxPoints)-6,
                        child: Text("80", style: TextStyle(fontSize: 12)),
                      ),
                      // 숫자 240
                      Positioned(
                        left: MediaQuery.of(context).size.width * (240 / maxPoints)-15,
                        child: Text("240", style: TextStyle(fontSize: 12)),
                      ),
                      // 숫자 720
                      Positioned(
                        left: MediaQuery.of(context).size.width * (720 / maxPoints)-30,
                        child: Text("720", style: TextStyle(fontSize: 12)),
                      ),
                      // 숫자 2160
                      Positioned(
                        right: 0, // 상태바의 끝점
                        child: Text("2,160", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // 텍스트 박스
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            decoration: BoxDecoration(
              color: Color(0xFFFCF9EC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 80),
          // 나무 이미지
          Image.asset(
            treeImage, // 상태에 따라 이미지 변경
            height: 150,
          ),
          // 하단 버튼들
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  label: '물주기',
                  points: '10p',
                  imagePath: 'assets/water.png',
                  onPressed: () => handleAction('물주기', 10),
                ),
                ActionButton(
                  label: '햇빛쐬기',
                  points: '20p',
                  imagePath: 'assets/sun.png',
                  onPressed: () => handleAction('햇빛쐬기', 20),
                ),
                ActionButton(
                  label: '비료주기',
                  points: '50p',
                  imagePath: 'assets/fertilizer.png',
                  onPressed: () => handleAction('비료주기', 50),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '달력'),
          BottomNavigationBarItem(icon: Icon(Icons.nature), label: '내 나무'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final String points;
  final String imagePath; // 이미지 경로 전달받기
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.label,
    required this.points,
    required this.imagePath, // 이미지 경로
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF67EACA)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // 이미지 추가
                Image.asset(
                imagePath, // 이미지 경로 사용
                height: 40, // 이미지 높이
                width: 40, // 이미지 너비
                ),
                  SizedBox(height: 8,),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                width: 40,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFB0F4E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  points,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
