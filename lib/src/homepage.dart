import 'package:flutter/material.dart';
import 'package:racha_racha/src/presenter/screens/history/history_screen.dart';
import 'package:racha_racha/src/presenter/screens/history/provider/history_screen_provider.dart';
import 'package:racha_racha/src/presenter/screens/settings/settings_screen.dart';
import 'package:racha_racha/src/presenter/shared/routes/app_route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: titleAppBar(), backgroundColor: Colors.deepPurple),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(height: 5),
                  Image.asset('assets/images/Image1.jpeg', width: 200),
                  const SizedBox(height: 10),
                  Image.asset('assets/images/Image2.jpeg', width: 200),
                  const SizedBox(height: 35),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 5),
                  Image.asset('assets/images/Image3.jpeg', width: 200),
                  const SizedBox(height: 10),
                  Image.asset('assets/images/Image4.jpeg', width: 200),
                  const SizedBox(height: 35),
                ],
              ),
            ],
          ),
          const JumpingText(), // )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRouteManager.totalValue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text(
          'Começar',
          style: TextStyle(fontWeight: FontWeight.bold, shadows: [
            Shadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2))
          ]),
        ),
      ),
      bottomNavigationBar: NavigationBar(context),
    );
  }

  Center titleAppBar() {
    return Center(
      child: Text(
        '=   Racha Racha   =',
        style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(2, 2))
            ]),
      ),
    );
  }
}

class JumpingText extends StatefulWidget {
  const JumpingText({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JumpingTextState createState() => _JumpingTextState();
}

class _JumpingTextState extends State<JumpingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetY;
  late Animation<double> _shadowBlur;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    // Texto sobe
    _offsetY = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Sombra cresce conforme sobe
    _shadowBlur = Tween<double>(begin: 4, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offsetY.value),
          child: Text(
            'Aqui a conta também faz parte da diversão',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: Colors.deepPurple,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(0, _shadowBlur.value * 0.3),
                  blurRadius: _shadowBlur.value,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ignore: non_constant_identifier_names
BottomNavigationBar NavigationBar(BuildContext context) {
  return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      iconSize: 35,
      backgroundColor: Colors.deepPurple,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HistoryScreenProvider(
                child: HistoryScreenWrapper(),
              ),
            ),
          );
        }

        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsScreen(),
            ),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Divisões'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Menu'),
      ]);
}

//Seria para usar na rolagem das imagens (por exemplo no carouselView)
final List<String> imagens = [
  'assets/images/Image1.jpeg'
      'assets/images/Image2.jpeg'
      'assets/images/Image3.jpeg'
      'assets/images/Image4.jpeg'
      'assets/images/Image5.jpeg'
      'assets/images/Image6.jpeg'
      'assets/images/Image7.jpeg'
];
