import 'dartd:math' as math;
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
  bool isMyComputerOpen = false;

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('HH:mm').format(DateTime.now());
    final dateString = DateFormat('dd.MM.yyyy').format(DateTime.now());

    return Scaffold(
      body: Stack(
        children: [
          // 1. АВТЕНТИЧНИЙ ФОН WINDOWS 7 AERO (ВЕКТОРНИЙ ПРАПОР ТА ПРОМЕНІ)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.35, -0.15),
                  radius: 1.35,
                  colors: [
                    Color(0xFF2C8FCB),
                    Color(0xFF14548E),
                    Color(0xFF071B33),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: Win7AeroRaysPainter(),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 220,
                      child: CustomPaint(
                        painter: Win7AeroFlagPainter(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. ІКОНКИ РОБОЧОГО СТОЛУ
          Positioned(
            top: 30,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDesktopIcon(
                  label: 'Комп\'ютер',
                  icon: Icons.computer,
                  onTap: () => setState(() => isMyComputerOpen = true),
                ),
                const SizedBox(height: 20),
                _buildDesktopIcon(
                  label: 'Кошик',
                  icon: Icons.delete_outline,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // 3. ВІКНО "КОМП'ЮТЕР"
          if (isMyComputerOpen)
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Container(
                height: 380,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF4B85C5), width: 2),
                  boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 20)],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                        gradient: LinearGradient(
                          colors: [Color(0xFFE2F0FD), Color(0xFF99BFE4), Color(0xFF6B94C2)],
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.computer, size: 16, color: Color(0xFF143254)),
                          const SizedBox(width: 8),
                          const Text('Комп\'ютер', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => setState(() => isMyComputerOpen = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9381E),
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.white70),
                              ),
                              child: const Text('✕', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            _buildDriveCard('Локальний диск (C:)', '45.2 ГБ вільних з 118 ГБ', 0.6),
                            const SizedBox(width: 15),
                            _buildDriveCard('Локальний диск (D:)', '210 ГБ вільних з 465 ГБ', 0.45),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          // 4. МЕНЮ "ПУСК" WINDOWS 7
          if (isStartOpen)
            Positioned(
              left: 0,
              bottom: 40,
              child: Container(
                width: 360,
                height: 440,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(8)),
                  border: Border.all(color: const Color(0xFF7CB6E8), width: 1.5),
                  boxShadow: const [BoxShadow(color: Colors.black87, blurRadius: 25)],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF285482).withOpacity(0.95),
                      const Color(0xFF0A1C2E).withOpacity(0.98),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      // Ліва колонка
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: const Color(0xFF8BAECF)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  children: [
                                    _buildStartAppItem(Icons.language, 'Internet Explorer', Colors.lightBlue),
                                    _buildStartAppItem(Icons.play_circle_filled, 'Windows Media Center', Colors.green),
                                    _buildStartAppItem(Icons.calculate, 'Калькулятор', Colors.blueGrey),
                                    _buildStartAppItem(Icons.sticky_note_2, 'Записки', Colors.amber),
                                    _buildStartAppItem(Icons.content_cut, 'Ножиці', Colors.redAccent),
                                    _buildStartAppItem(Icons.palette, 'Paint', Colors.purple),
                                  ],
                                ),
                              ),
                              const Divider(height: 1),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_right, color: Colors.black),
                                    Text('Усі програми', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Права колонка
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            _buildRightText('User', isBold: true),
                            const Divider(color: Colors.white30),
                            _buildRightText('Документи'),
                            _buildRightText('Зображення'),
                            _buildRightText('Музика'),
                            const Divider(color: Colors.white30),
                            _buildRightText('Комп\'ютер', onTap: () {
                              setState(() {
                                isMyComputerOpen = true;
                                isStartOpen = false;
                              });
                            }),
                            _buildRightText('Панель керування'),
                            const Spacer(),
                            Container(
                              height: 30,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [Color(0xFF3B82C4), Color(0xFF163E66)]),
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.white70),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.power_settings_new, color: Colors.white, size: 15),
                                  SizedBox(width: 4),
                                  Text('Завершення роботи', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 5. ПАНЕЛЬ ЗАВДАНЬ AERO TASKBAR
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
                    Colors.white.withOpacity(0.4),
                    const Color(0xFF1B4E7E).withOpacity(0.8),
                    const Color(0xFF081625).withOpacity(0.95),
                  ],
                ),
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.6), width: 1)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => isStartOpen = !isStartOpen),
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          center: Alignment(-0.2, -0.3),
                          colors: [Color(0xFF7CD4FF), Color(0xFF0058B3), Color(0xFF001B48)],
                        ),
                        border: Border.all(color: Colors.white, width: 1.5),
                        boxShadow: const [BoxShadow(color: Color(0xFF00E5FF), blurRadius: 8)],
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CustomPaint(painter: Win7AeroFlagPainter(isSmall: true)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.folder_special, color: Colors.amber, size: 22),
                  const SizedBox(width: 10),
                  const Icon(Icons.language, color: Colors.lightBlueAccent, size: 22),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(timeString, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        Text(dateString, style: const TextStyle(color: Colors.white70, fontSize: 9)),
                      ],
                    ),
                  ),
                  Container(
                    width: 14,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      border: Border(left: BorderSide(color: Colors.white.withOpacity(0.5))),
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

  Widget _buildDesktopIcon({required String label, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.18),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 6)],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, shadows: [Shadow(blurRadius: 4, color: Colors.black)])),
        ],
      ),
    );
  }

  Widget _buildDriveCard(String title, String subtitle, double percent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
        child: Row(
          children: [
            const Icon(Icons.dns, size: 36, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(value: percent, backgroundColor: Colors.grey.shade200, color: Colors.blue),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 9, color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStartAppItem(IconData icon, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildRightText(String text, {bool isBold = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }
}

// МАЛЮВАННЯ ХВИЛЯСТОГО ПРАПОРА WINDOWS 7
class Win7AeroFlagPainter extends CustomPainter {
  final bool isSmall;
  Win7AeroFlagPainter({this.isSmall = false});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.save();
    canvas.rotate(-12 * math.pi / 180);

    void drawWavyQuad(Path path, Color color) {
      canvas.drawPath(path, Paint()..color = color);
    }

    final pathRed = Path()
      ..moveTo(w * 0.05, h * 0.1)
      ..quadraticBezierTo(w * 0.25, h * 0.0, w * 0.45, h * 0.1)
      ..lineTo(w * 0.43, h * 0.45)
      ..quadraticBezierTo(w * 0.23, h * 0.35, w * 0.03, h * 0.45)
      ..close();
    drawWavyQuad(pathRed, const Color(0xFFEE4023));

    final pathGreen = Path()
      ..moveTo(w * 0.52, h * 0.08)
      ..quadraticBezierTo(w * 0.72, h * 0.02, w * 0.95, h * 0.12)
      ..lineTo(w * 0.93, h * 0.47)
      ..quadraticBezierTo(w * 0.70, h * 0.37, w * 0.50, h * 0.43)
      ..close();
    drawWavyQuad(pathGreen, const Color(0xFF7FBC00));

    final pathBlue = Path()
      ..moveTo(w * 0.03, h * 0.52)
      ..quadraticBezierTo(w * 0.23, h * 0.42, w * 0.43, h * 0.52)
      ..lineTo(w * 0.41, h * 0.88)
      ..quadraticBezierTo(w * 0.21, h * 0.78, w * 0.01, h * 0.88)
      ..close();
    drawWavyQuad(pathBlue, const Color(0xFF00A3EE));

    final pathYellow = Path()
      ..moveTo(w * 0.50, h * 0.50)
      ..quadraticBezierTo(w * 0.70, h * 0.44, w * 0.92, h * 0.54)
      ..lineTo(w * 0.90, h * 0.90)
      ..quadraticBezierTo(w * 0.68, h * 0.80, w * 0.48, h * 0.86)
      ..close();
    drawWavyQuad(pathYellow, const Color(0xFFFFB900));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// МАЛЮВАННЯ ХВИЛЬ ТА ПРОМЕНІВ AERO
class Win7AeroRaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.cyanAccent.withOpacity(0.18),
          Colors.lightBlue.withOpacity(0.08),
          Colors.transparent,
        ],
      ).createShader(rect);

    final path = Path()
      ..moveTo(0, size.height * 0.3)
      ..cubicTo(size.width * 0.4, size.height * 0.2, size.width * 0.6, size.height * 0.7, size.width, size.height * 0.5)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
