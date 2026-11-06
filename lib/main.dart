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
          // 1. ОРИГІНАЛЬНІ ШПАЛЕРИ WINDOWS 7 (Автентичний фон + Прапор)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.3, -0.2),
                  radius: 1.4,
                  colors: [
                    Color(0xFF3393DF),
                    Color(0xFF155FA0),
                    Color(0xFF092949),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: Win7AeroBackgroundPainter(),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: CustomPaint(
                        painter: Win7LogoPainter(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. ІКОНКИ РОБОЧОГО СТОЛУ (Класичний стиль Windows 7)
          Positioned(
            top: 20,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWin7DesktopIcon(
                  label: 'Комп\'ютер',
                  iconType: Win7IconType.computer,
                  onTap: () {
                    setState(() {
                      isMyComputerOpen = true;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildWin7DesktopIcon(
                  label: 'Кошик',
                  iconType: Win7IconType.trash,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // 3. ВІКНО "КОМП'ЮТЕР" (AERO GLASS WINDOW)
          if (isMyComputerOpen)
            Positioned(
              top: 50,
              left: 15,
              right: 15,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF5B9BD5), width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black54, blurRadius: 20, spreadRadius: 2)
                  ],
                ),
                child: Column(
                  children: [
                    // Заголовок вікна Windows 7 Aero
                    Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                        gradient: LinearGradient(
                          colors: [Color(0xFFDCEBFA), Color(0xFFA8C4E3), Color(0xFF7A9EC7)],
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.computer, size: 18, color: Color(0xFF1E4267)),
                          const SizedBox(width: 8),
                          const Text(
                            'Комп\'ютер',
                            style: TextStyle(
                              color: Color(0xFF0F2537),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMyComputerOpen = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade700,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.white70),
                              ),
                              child: const Text(
                                '✕',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Меню папки
                    Container(
                      height: 28,
                      color: const Color(0xFFE5F3FF),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: const [
                          Text('Властивості системи', style: TextStyle(fontSize: 11, color: Colors.blue)),
                          SizedBox(width: 15),
                          Text('Видалити або змінити програму', style: TextStyle(fontSize: 11, color: Colors.blue)),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Диски
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Пристрої з знімними носіями (2)',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E4267)),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _buildDriveCard('Локальний диск (C:)', '45.2 ГБ вільних з 118 ГБ', 0.6),
                                const SizedBox(width: 15),
                                _buildDriveCard('Локальний диск (D:)', '210 ГБ вільних з 465 ГБ', 0.45),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          // 4. ОРИГІНАЛЬНЕ МЕНЮ "ПУСК" WINDOWS 7
          if (isStartOpen)
            Positioned(
              left: 0,
              bottom: 40,
              child: Container(
                width: 380,
                height: 480,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  border: Border.all(color: const Color(0xFF6BB2E6), width: 1.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black87, blurRadius: 25, spreadRadius: 5)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF336699).withOpacity(0.94),
                      const Color(0xFF0C1B2A).withOpacity(0.97),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      // Ліва колонка (Програми)
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFF8BAECF)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  children: [
                                    _buildStartApp(Icons.public, 'Internet Explorer', Colors.lightBlue),
                                    _buildStartApp(Icons.play_circle_fill, 'Windows Media Center', Colors.green),
                                    _buildStartApp(Icons.calculate, 'Калькулятор', Colors.blueGrey),
                                    _buildStartApp(Icons.note_alt, 'Записки', Colors.amber),
                                    _buildStartApp(Icons.content_cut, 'Ножиці', Colors.redAccent),
                                    _buildStartApp(Icons.palette, 'Paint', Colors.purple),
                                    _buildStartApp(Icons.games, 'Ігри', Colors.orange),
                                  ],
                                ),
                              ),
                              const Divider(height: 1),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: const [
                                    Icon(Icons.arrow_right, color: Colors.black87),
                                    SizedBox(width: 4),
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
                      const SizedBox(width: 6),
                      // Права колонка (Системні папки)
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
                            _buildRightMenuItem('Комп\'ютер', onTap: () {
                              setState(() {
                                isMyComputerOpen = true;
                                isStartOpen = false;
                              });
                            }),
                            _buildRightMenuItem('Панель керування'),
                            _buildRightMenuItem('Пристрої та принтери'),
                            const Spacer(),
                            // Кнопка Завершення роботи
                            Container(
                              height: 32,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF4289C7), Color(0xFF163E66)],
                                ),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.white70),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.power_settings_new, color: Colors.white, size: 16),
                                  SizedBox(width: 6),
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

          // 5. ПАНЕЛЬ ЗАВДАНЬ (AERO TASKBAR)
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
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.6), width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Кнопка "Пуск" (Оригінальна кругла куля Aero Orb)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isStartOpen = !isStartOpen;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          center: Alignment(-0.2, -0.3),
                          colors: [
                            Color(0xFF7CD4FF),
                            Color(0xFF0058B3),
                            Color(0xFF001B48),
                          ],
                        ),
                        border: Border.all(color: Colors.white, width: 1.5),
                        boxShadow: const [
                          BoxShadow(color: Color(0xFF00E5FF), blurRadius: 8)
                        ],
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CustomPaint(painter: Win7LogoPainter()),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.folder_special, color: Colors.amber, size: 22),
                  const SizedBox(width: 10),
                  const Icon(Icons.language, color: Colors.lightBlueAccent, size: 22),
                  const Spacer(),
                  // Системний трей і годинник
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

  Widget _buildWin7DesktopIcon({
    required String label,
    required Win7IconType iconType,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 6)],
            ),
            child: Center(
              child: Icon(
                iconType == Win7IconType.computer ? Icons.computer : Icons.delete_outline,
                color: Colors.white,
                size: 32,
              ),
            ),
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
      ),
    );
  }

  Widget _buildDriveCard(String title, String subtitle, double percent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.dns, size: 36, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildStartApp(IconData icon, String title, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildRightMenuItem(String text, {bool isBold = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}

enum Win7IconType { computer, trash }

// МАЛЮВАННЯ ЛОГОТИПУ WINDOWS 7 (ЧОТИРИ КОЛЬОРОВІ ПРАПОРИ)
class Win7LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final redPaint = Paint()..color = const Color(0xFFF25022);
    final greenPaint = Paint()..color = const Color(0xFF7FBA00);
    final bluePaint = Paint()..color = const Color(0xFF00A4EF);
    final yellowPaint = Paint()..color = const Color(0xFFFFB900);

    // Верхній лівий (Червоний)
    canvas.drawRect(Rect.fromLTWH(0, 0, w * 0.46, h * 0.46), redPaint);
    // Верхній правий (Зелений)
    canvas.drawRect(Rect.fromLTWH(w * 0.54, 0, w * 0.46, h * 0.46), greenPaint);
    // Нижній лівий (Синій)
    canvas.drawRect(Rect.fromLTWH(0, h * 0.54, w * 0.46, h * 0.46), bluePaint);
    // Нижній правий (Жовтий)
    canvas.drawRect(Rect.fromLTWH(w * 0.54, h * 0.54, w * 0.46, h * 0.46), yellowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// МАЛЮВАННЯ СВІТЛОВИХ ХВИЛЬ AERO GLASS
class Win7AeroBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..cubicTo(size.width * 0.3, size.height * 0.35, size.width * 0.7, size.height * 0.65, size.width, size.height * 0.4)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.cyanAccent.withOpacity(0.2),
          Colors.blue.withOpacity(0.05),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
