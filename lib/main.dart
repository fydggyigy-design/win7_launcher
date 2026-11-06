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
      title: 'Windows 7 Simulator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: Colors.blue,
      ),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/1080/1920'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Shortcut
            Positioned(
              left: 20,
              top: 40,
              child: Column(
                children: const [
                  Icon(Icons.computer, size: 48, color: Colors.white),
                  SizedBox(height: 4),
                  Text(
                    'Computer',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),

            // Start Menu
            if (isStartOpen)
              Positioned(
                left: 0,
                bottom: 40,
                child: Container(
                  width: 250,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                    ),
                    border: Border.all(color: Colors.lightBlueAccent),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.blue.shade900,
                        child: Row(
                          children: const [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'User',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Windows 7 Menu',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Taskbar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  border: const Border(
                    top: BorderSide(color: Colors.lightBlueAccent, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.window, color: Colors.lightBlueAccent),
                      onPressed: () {
                        setState(() {
                          isStartOpen = !isStartOpen;
                        });
                      },
                    ),
                    const VerticalDivider(color: Colors.grey),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            timeString,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            dateString,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
