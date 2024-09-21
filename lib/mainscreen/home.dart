import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

enum CardInfo {
  camera('أسئلة', Color(0xFF460C75), Color(0xFFF3E9FB)),
  lighting('تحدي أو صراحة', Color(0xFF460C75), Color(0xFFF3E9FB));
  
  const CardInfo(this.label, this.color, this.backgroundColor);
  final String label;
  final Color color;
  final Color backgroundColor;
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // تغيير الارتفاع حسب الحاجة
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30.0), // تحديد مدى الانحناء
          ),
          child: AppBar(
            title: Text(
              'العفش',
              style: GoogleFonts.tajawal(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF460C75),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: CardInfo.values.map((card) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (card == CardInfo.camera) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Question()),
                    );
                  } else if (card == CardInfo.lighting) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LightingPage()),
                    );
                  }
                },
                child: Card(
                  color: card.backgroundColor,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(30.0),
                    title: Text(
                      card.label,
                        textAlign: TextAlign.center,
                      style: GoogleFonts.tajawal(
                        fontSize: 50,
                        color: const Color.fromARGB(255, 70, 12, 117),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cardTexts = [
      'أكثر موقف محرج صارلك؟',
      '  مين أقرب شخص لقلبك حتى لو بعيد بالمسافة؟',
      ' أول ما تفرح أو تزعل مين يطري على بالك؟',
      '  مشكلة سويتها وطلعت فاهم خطأ',
      '  مكان يفشل بكيت فيه لسبب يفشل بعد؟',
      'أغبى شيء قلته في حياتك؟',
      ' تعمدت تجرح شخص يوم من الأيام وليش',
      ' هل قد ظلمت أحد؟',
      ' لو عندك أمنية وحدة ايش بتكون؟',
      'كلمة تقولها دائماً',
      ' هل فيه شخص فارقته بس ما تمنيت تفارقه وودك ترجع له ',
      '  قول سر محد يعرفه عنك',
      ' إذا سبق وأذيت شخص من الموجودين اعتذر له وبرر له ',
      '  لو تقدر تاخذ مكان احد بتاخذه؟ وايش المكان الي مستعد تاخذه من اي احد',
      'حكينا عن أقوى هوشة تهاوشتها',
      'علمنا عن كلمة جارحة قلتها بدون قصد وكل ما تتذكرها ياكلك ضميرك',
      ' لو بتغير اسمك ايش بتختار؟',
      'موقف اثر بشخصيتك',
      ' تتوقع كم عندك عقدة نفسية',
      ' تحت عنوان رسائل لن تصل قول اي كلام لاي شخص ودك لو تقوله له وماقدرت',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back Icon',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(cardTexts.length, (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.white,
                shadowColor: Colors.grey,
                elevation: 5,
              ),
              child: Text(
                cardTexts[index],
                  textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 70, 12, 117),
                  ),
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class LightingPage extends StatefulWidget {
  const LightingPage({super.key});

  @override
  _LightingPageState createState() => _LightingPageState();
}

class _LightingPageState extends State<LightingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final _random = math.Random();
  double _angle = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _angle = _animation.value;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinWheel() {
    final double randomAngle = _random.nextDouble() * math.pi * 2;

    _animation = Tween<double>(
      begin: _angle,
      end: _angle + math.pi * 4 + randomAngle,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back Icon',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              child: Image.asset('assets/nova.png', width: 250, height: 250),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: child,
                );
              },
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: _spinWheel,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 12, 117),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: GoogleFonts.tajawal(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              child: const Text('دوّرها', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
