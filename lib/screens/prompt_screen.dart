import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prompt_handler/bloc/image_event.dart';
import '../bloc/image_bloc.dart';
import 'result_screen.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  final TextEditingController _controller = TextEditingController();
  String prompt = '';

  @override
  void initState() {
    super.initState();
    final saved = context.read<ImageBloc>().savedPrompt;
    _controller.text = saved;
    prompt = saved;
  }

  void _onGenerate() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const ResultScreen(),
    ));
    context.read<ImageBloc>().add(GenerateImage(prompt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prompt')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (value) => setState(() => prompt = value),
              decoration: const InputDecoration(
                hintText: 'Describe what you want to see…',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: prompt.trim().isEmpty ? null : _onGenerate,
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
