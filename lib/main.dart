import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/image_bloc.dart';
import 'screens/prompt_screen.dart';

void main() {
  runApp(const PromptApp());
}

class PromptApp extends StatelessWidget {
  const PromptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageBloc(),
      child: MaterialApp(
        title: 'Prompt Generator',
        theme: ThemeData(useMaterial3: true),
        home: const PromptScreen(),
      ),
    );
  }
}
