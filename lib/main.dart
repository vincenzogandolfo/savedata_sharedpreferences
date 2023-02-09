import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool darkModeEnabled = false;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((sharedPreferences) {
      final enabled = sharedPreferences.getBool('home_page.setting.dark_mode');
      setState(() {
        darkModeEnabled = enabled ?? false;
      });
    });
  }

  void onDarkModeToggle(bool enabled) async {
    setState(() {
      darkModeEnabled = enabled;
    });
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(
        'home_page.setting.dark_mode', darkModeEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Save Data - SharedPreferences'),
        ),
      ),
      body: Center(
        child: SwitchListTile(
          value: darkModeEnabled,
          secondary: const Icon(Icons.monochrome_photos),
          title: const Text(
            'Attiva Pulsante',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onChanged: onDarkModeToggle,
        ),
      ),
    );
  }
}
