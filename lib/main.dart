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
          // 1. Оригінальні шпалери Windows 7
          Positioned.fill(
            child: Image.network(
              'https://images.hdqwalls.com/wallpapers/windows-7-official-original-4k-yy.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF0D3B66),
              ),
            ),
          ),

          // 2. Іконки на робочому столі (Оригінальний стиль)
          Positioned(
            top: 20,
            left: 15,
            child: Column(
              children: [
                _buildWin7DesktopIcon(
                  'https://win11.blueedge.me/img/icon/win/computer.png',
                  'Комп\'ютер',
                ),
                const SizedBox(height: 20),
                _buildWin7DesktopIcon(
                  'https://win11.blueedge.me/img/icon/win/bin0.png',
                  'Кошик',
                ),
              ],
            ),
          ),

          // 3. Оригінальне меню "Пуск" Windows 7 (Aero Glass)
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
                  boxShadow: const [
                    BoxShadow(color: Colors.black87, blurRadius: 20, spreadRadius: 5)
                  ],
                  border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2B5784).withOpacity(0.85),
                      const Color(0xFF0E2238).withOpacity(0.92),
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
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.blueGrey.shade200),
                          ),
                          child: ListView(
                            padding: const EdgeInsets.all(4),
                            children: [
                              _buildStartItem('https://win11.blueedge.me/img/icon/win/edge.png', 'Internet Explorer'),
                              _buildStartItem('https://cdn-icons-png.flaticon.com/512/888/888871.png', 'Windows Media Player'),
                              _buildStartItem('https://cdn-icons-png.flaticon.com/512/3719/3719726.png', 'Блокнот'),
                              _buildStartItem('https://cdn-icons-png.flaticon.com/512/2344/2344132.png', 'Калькулятор'),
                              _buildStartItem('https://cdn-icons-png.flaticon.com/512/1260/1260111.png', 'Paint'),
                              const Divider(),
                              _buildStartItem('https://win11.blueedge.me/img/icon/win/folder.png', 'Усі програми'),
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
                            const SizedBox(height: 10),
                            _buildRightText('User'),
                            const Divider(color: Colors.white30),
                            _buildRightText('Документи'),
                            _buildRightText('Зображення'),
                            _buildRightText('Музика'),
                            const Divider(color: Colors.white30),
                            _buildRightText('Комп\'ютер'),
                            _buildRightText('Панель керування'),
                            _buildRightText('Пристрої та принтери'),
                            const Spacer(),
                            // Кнопка Завершення роботи
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF3B82C4), Color(0xFF163E66)],
                                ),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.white54),
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 4. Панель завдань Aero Glass (Taskbar)
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
                    Colors.white.withOpacity(0.3),
                    const Color(0xFF1E4C7A).withOpacity(0.7),
                    const Color(0xFF091724).withOpacity(0.9),
                  ],
                ),
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Кнопка Пуск (Оригінальна кругла куля)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isStartOpen = !isStartOpen;
                      });
                    },
                    child: Container(
                      width: 48,
                      height: 40,
                      alignment: Alignment.center,
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Windows_logo_-_2006.svg/512px-Windows_logo_-_2006.svg.png',
                        width: 32,
                        height: 32,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.window, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Іконки швидкого запуску
                  Image.network('https://win11.blueedge.me/img/icon/win/folder.png', width: 22),
                  const SizedBox(width: 12),
                  Image.network('https://win11.blueedge.me/img/icon/win/edge.png', width: 22),
                  const Spacer(),
                  // Системний трей і годинник
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  // Згорнути всі вікна (Прямокутник праворуч)
                  Container(
                    width: 14,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
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

  Widget _buildWin7DesktopIcon(String iconUrl, String title) {
    return Column(
      children: [
        Image.network(
          iconUrl,
          width: 44,
          height: 44,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.computer, size: 44, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          title,
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

  Widget _buildStartItem(String iconUrl, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        children: [
          Image.network(iconUrl, width: 22, height: 22),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildRightText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11, shadows: [Shadow(blurRadius: 2, color: Colors.black)]),
      ),
    );
  }
}
