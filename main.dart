import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() => runApp(const Win7SurfaceApp());

class Win7SurfaceApp extends StatelessWidget {
  const Win7SurfaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Windows 7 Surface Edition',
      theme: ThemeData(fontFamily: 'Segoe UI'),
      home: const Win7VerticalDesktop(),
    );
  }
}

class Win7VerticalDesktop extends StatefulWidget {
  const Win7VerticalDesktop({Key? key}) : super(key: key);

  @override
  State<Win7VerticalDesktop> createState() => _Win7VerticalDesktopState();
}

class _Win7VerticalDesktopState extends State<Win7VerticalDesktop> {
  bool _isStartMenuOpen = false;
  String _currentTime = '';
  String _currentDate = '';
  Timer? _timer;

  // Official Windows 7 icon URLs
  final String _computerIcon = 'https://img.icons8.com/color/96/my-computer.png';
  final String _recycleBin = 'https://img.icons8.com/color/96/recycle-bin.png';
  final String _folderIcon = 'https://img.icons8.com/color/96/folder-invoices.png';
  final String _ieIcon = 'https://img.icons8.com/color/96/internet-explorer.png';
  final String _startOrb = 'https://img.icons8.com/color/96/windows-7.png';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat('h:mm a').format(now);
      _currentDate = DateFormat('M/d/yyyy').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Windows 7 Bliss Wallpaper (Vertical format adapted)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1508739773434-c26b3d09e071?q=80&w=1080&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Vertical Desktop Icons Grid (Optimized for Motorola g06)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 24.0,
              runSpacing: 20.0,
              children: [
                _buildDesktopIcon(iconUrl: _computerIcon, label: 'Computer', onTap: () {}),
                _buildDesktopIcon(iconUrl: _folderIcon, label: 'Documents', onTap: () {}),
                _buildDesktopIcon(iconUrl: _ieIcon, label: 'Internet Explorer', onTap: () {}),
                _buildDesktopIcon(iconUrl: _recycleBin, label: 'Recycle Bin', onTap: () {}),
              ],
            ),
          ),

          // 3. Start Menu Overlay (Vertical Phone Edition)
          if (_isStartMenuOpen)
            Positioned(
              bottom: 48.0,
              left: 0,
              right: 0,
              child: Container(
                height: 420.0,
                decoration: BoxDecoration(
                  color: const Color(0xEFEFEFEF),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                  border: Border.all(color: Colors.blue.withOpacity(0.5), width: 1.5),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, spreadRadius: 2),
                  ],
                ),
                child: Row(
                  children: [
                    // Left Side: Pinned Apps
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStartItem(_computerIcon, 'Control Panel'),
                            _buildStartItem(_ieIcon, 'Internet Explorer'),
                            _buildStartItem(_folderIcon, 'Documents'),
                            const Spacer(),
                            const Text('All Programs', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                    // Right Side: Quick Links
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2EEF8),
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(12.0)),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('User Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            const SizedBox(height: 15),
                            const Text('Documents', style: TextStyle(fontSize: 12)),
                            const SizedBox(height: 10),
                            const Text('Pictures', style: TextStyle(fontSize: 12)),
                            const Spacer(),
                            const Divider(),
                            const Text('Shut down', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 4. Windows 7 Taskbar (Bottom)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 48.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xEE2A52BE), Color(0xEE0B1D51)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border(top: BorderSide(color: Color(0x77FFFFFF), width: 1.0)),
              ),
              child: Row(
                children: [
                  // Start Orb Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isStartMenuOpen = !_isStartMenuOpen;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      margin: const EdgeInsets.only(left: 6.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFF1B5E20)]),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.white.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          Image.network(_startOrb, width: 22, height: 22),
                          const SizedBox(width: 6),
                          const Text(
                            'Start',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  // System Tray Clock (Zakarpattia local time)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    margin: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _currentTime,
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _currentDate,
                          style: const TextStyle(color: Colors.white70, fontSize: 10),
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
    );
  }

  Widget _buildDesktopIcon({required String iconUrl, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 75,
        child: Column(
          children: [
            Image.network(iconUrl, width: 48, height: 48),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                shadows: [Shadow(color: Colors.black, blurRadius: 3, offset: Offset(1, 1))],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartItem(String iconUrl, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.network(iconUrl, width: 24, height: 24),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }
}
// Part 2: Windows 7 File Explorer / Computer Window Module
class Win7ExplorerWindow extends StatefulWidget {
  final VoidCallback onClose;

  const Win7ExplorerWindow({Key? key, required this.onClose}) : super(key: key);

  @override
  State<Win7ExplorerWindow> createState() => _Win7ExplorerWindowState();
}

class _Win7ExplorerWindowState extends State<Win7ExplorerWindow> {
  // Initial window position on screen
  double _posX = 20.0;
  double _posY = 50.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _posX,
      top: _posY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _posX += details.delta.dx;
            _posY += details.delta.dy;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 380,
          decoration: BoxDecoration(
            color: const Color(0xFFAFAFAF).withOpacity(0.9), // Aero glass effect
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFF0078D7), // Windows Aero blue accent border
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 20.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            children: [
              // Window Title Bar with Aero Gradient
              Container(
                height: 34.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF63B8FF), Color(0xFF1C6EA4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8.0),
                    Image.network(
                      'https://img.icons8.com/color/96/my-computer.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 6.0),
                    const Text(
                      'Computer',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        shadows: [
                          Shadow(color: Colors.black54, offset: Offset(1, 1), blurRadius: 2),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Minimize button
                    _buildWindowButton(Icons.remove, () {}),
                    // Maximize button
                    _buildWindowButton(Icons.crop_square, () {}),
                    // Close button
                    _buildWindowButton(Icons.close, widget.onClose, isClose: true),
                    const SizedBox(width: 4.0),
                  ],
                ),
              ),

              // Window Toolbar (Organize, System properties, etc.)
              Container(
                height: 36.0,
                color: const Color(0xFFF0F0F0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: const [
                    Text('Organize', style: TextStyle(fontSize: 12, color: Colors.black8N || Colors.black)),
                    SizedBox(width: 15),
                    Text('System properties', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    SizedBox(width: 15),
                    Text('Uninstall or change a program', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),

              // Window Content (Sidebar + Main Drives View)
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      // Left Sidebar Navigation
                      Container(
                        width: 120.0,
                        color: const Color(0xFFF7F7F7),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey)),
                            SizedBox(height: 4),
                            Text('Desktop', style: TextStyle(fontSize: 11, color: Colors.blue)),
                            Text('Downloads', style: TextStyle(fontSize: 11)),
                            SizedBox(height: 12),
                            Text('Libraries', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey)),
                            SizedBox(height: 4),
                            Text('Documents', style: TextStyle(fontSize: 11)),
                            Text('Pictures', style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      // Vertical Divider
                      const VerticalDivider(width: 1, color: Colors.grey),
                      // Main View: Hard Drives
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hard Disk Drives (1)',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.network(
                                    'https://img.icons8.com/color/96/ssd.png',
                                    width: 32,
                                    height: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Windows 7 (C:)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                        const SizedBox(height: 4),
                                        LinearProgressIndicator(
                                          value: 0.65,
                                          backgroundColor: Colors.grey[300],
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(height: 4),
                                        const Text('35.2 GB free of 100 GB', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWindowButton(IconData icon, VoidCallback onTap, {bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        width: 22,
        height: 18,
        decoration: BoxDecoration(
          color: isClose ? const Color(0xFFE81123) : Colors.transparent,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
    );
  }
}
