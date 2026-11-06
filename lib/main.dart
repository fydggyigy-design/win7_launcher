import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const Win7App());
}

class Win7App extends StatelessWidget {
  const Win7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Windows 7',
      debugShowCheckedModeBanner: false,
      home: const DesktopScreen(),
    );
  }
}

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  bool isStartOpen = false;

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('HH:mm').format(DateTime.now());
    final dateString = DateFormat('dd.MM.yyyy').format(DateTime.now());

    return Scaffold(
      body: Stack(
        children: [
          // 1. Оригінальні фонові хвилі Windows 7 (Aero Background)
          Positioned.fill(
            child: CustomPaint(
              painter: Win7WallpaperPainter(),
            ),
          ),

          // 2. Робочий стіл - Іконки (Комп'ютер, Кошик)
          Positioned(
            top: 25,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildWin7Icon(
                  icon: Icons.monitor,
                  label: 'Комп\'ютер',
                  badgeColor: Colors.blueAccent,
                ),
                const SizedBox(height: 25),
                _buildWin7Icon(
                  icon: Icons.delete_sweep,
                  label: 'Кошик',
                  badgeColor: Colors.grey,
                ),
              ],
            ),
          ),

          // 3. Меню "Пуск" Aero Glass 1-в-1
          if (isStartOpen)
            Positioned(
              left: 0,
              bottom: 40,
              child: Container(
                width: 360,
                height: 460,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  border: Border.all(color: const Color(0xFF709FE6), width: 1.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black54, blurRadius: 20, spreadRadius: 4)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2C5680).withOpacity(0.92),
                      const Color(0xFF0F263D).withOpacity(0.96),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      // Ліва колонка (Програми)
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: const Color(0xFF9FBAD4)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  children: [
                                    _buildStartApp(Icons.explore, 'Internet Explorer', Colors.lightBlue),
                                    _buildStartApp(Icons.play_circle_filled, 'Windows Media Player', Colors.orange),
                                    _buildStartApp(Icons.calculate, 'Калькулятор', Colors.green),
                                    _buildStartApp(Icons.sticky_note_2, 'Записки', Colors.amber),
                                    _buildStartApp(Icons.crop_original, 'Ножиці', Colors.redAccent),
                                    _buildStartApp(Icons.draw, 'Paint', Colors.purple),
                                  ],
                                ),
                              ),
                              const Divider(height: 1),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  children: const [
                                    Icon(Icons.arrow_right, color: Colors.black54),
                                    Text(
                                      'Усі програми',
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Права колонка (Система)
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            _buildRightMenuItem('User', isBold: true),
                            const Divider(color: Colors.white30, indent: 8, endIndent: 8),
                            _buildRightMenuItem('Документи'),
                            _buildRightMenuItem('Зображення'),
                            _buildRightMenuItem('Музика'),
                            _buildRightMenuItem('Ігри'),
                            const Divider(color: Colors.white30, indent: 8, endIndent: 8),
                            _buildRightMenuItem('Комп\'ютер'),
                            _buildRightMenuItem('Панель керування'),
                            _buildRightMenuItem('Пристрої та принтери'),
                            const Spacer(),
                            // Кнопка Завершення роботи
                            Container(
                              height: 30,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF4B93D1), Color(0xFF1B4975)],
                                ),
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.white60),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.power_settings_new, color: Colors.white, size: 15),
                                  SizedBox(width: 4),
                                  Text(
                                    'Завершення роботи',
                                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 4. Панель завдань (Taskbar) Aero Glass
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.35),
                    const Color(0xFF1B456E).withOpacity(0.75),
                    const Color(0xFF081524).withOpacity(0.95),
                  ],
                ),
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Кнопка "Пуск" (Кругла Aero Orb)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isStartOpen = !isStartOpen;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          center: Alignment(-0.2, -0.3),
                          colors: [
                            Color(0xFF62C5FF),
                            Color(0xFF005BB5),
                            Color(0xFF001F4D),
                          ],
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0.85), width: 1.5),
                        boxShadow: const [
                          BoxShadow(color: Color(0xFF00E5FF), blurRadius: 6)
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.window, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Швидкий запуск
                  const Icon(Icons.folder, color: Colors.amber, size: 22),
                  const SizedBox(width: 10),
                  const Icon(Icons.public, color: Colors.lightBlueAccent, size: 22),
                  const Spacer(),
                  // Системний трей і годинник
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          timeString,
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          dateString,
                          style: const TextStyle(color: Colors.white70, fontSize: 9),
                        ),
                      ],
                    ),
                  ),
                  // Кнопка "Згорнути все"
                  Container(
                    width: 12,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      border: Border(left: BorderSide(color: Colors.white.withOpacity(0.4))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWin7Icon({required IconData icon, required String label, required Color badgeColor}) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            shadows: [
              Shadow(blurRadius: 4, color: Colors.black),
              Shadow(blurRadius: 4, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStartApp(IconData icon, String title, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildRightMenuItem(String text, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          shadows: const [Shadow(blurRadius: 2, color: Colors.black)],
        ),
      ),
    );
  }
}

// Малювання оригінальних фонових хвиль Windows 7
class Win7WallpaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    
    // Фон
    final bgGradient = RadialGradient(
      center: const Alignment(0.4, -0.2),
      radius: 1.3,
      colors: const [
        Color(0xFF2E86DE),
        Color(0xFF1B4F8A),
        Color(0xFF0A1E36),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = bgGradient.createShader(rect));

    // Хвилі
    final path1 = Path()
      ..moveTo(0, size.height * 0.4)
      ..cubicTo(size.width * 0.3, size.height * 0.2, size.width * 0.7, size.height * 0.6, size.width, size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final wavePaint1 = Paint()
      ..shader = LinearGradient(
        colors: [Colors.cyanAccent.withOpacity(0.15), Colors.blueAccent.withOpacity(0.05)],
      ).createShader(rect);

    canvas.drawPath(path1, wavePaint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
