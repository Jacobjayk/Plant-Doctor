import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plant_doctor/screens/home_screen.dart';
import 'package:plant_doctor/screens/camera_screen.dart';
import 'package:plant_doctor/screens/history_screen.dart';
import 'package:plant_doctor/screens/settings_screen.dart';
import 'package:plant_doctor/services/ml_service.dart';
import 'package:plant_doctor/services/database_service.dart';
import 'package:plant_doctor/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  
  // Initialize services
  final mlService = MLService();
  final databaseService = DatabaseService();
  
  await mlService.initialize();
  await databaseService.initialize();
  
  runApp(MyApp(
    mlService: mlService,
    databaseService: databaseService,
  ));
}

class MyApp extends StatelessWidget {
  final MLService mlService;
  final DatabaseService databaseService;

  const MyApp({
    super.key,
    required this.mlService,
    required this.databaseService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MLService>.value(value: mlService),
        Provider<DatabaseService>.value(value: databaseService),
      ],
      child: MaterialApp(
        title: 'Plant Doctor',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
        ),
        home: const MainNavigationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const CameraScreen(useCamera: true),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

