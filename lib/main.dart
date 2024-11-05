import 'package:flutter/material.dart';
import 'package:note_app/models/note_database.dart';
import 'package:note_app/pages/note_page.dart';
import 'package:note_app/pages/settings.dart';
import 'package:note_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initiallize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteDataBase(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        "/home": (context) => const NotePage(),
        "/settings": (context) => const Settings(),
      },
    );
  }
}
