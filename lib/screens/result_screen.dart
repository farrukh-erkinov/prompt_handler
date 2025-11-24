import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/image_bloc.dart';
import '../bloc/image_state.dart';
import '../bloc/image_event.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ImageSuccess) {
            return _buildImageView(context, state.url);
          } else if (state is ImageFailure) {
            return _buildError(context);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildImageView(BuildContext context, String url) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                url,
                key: ValueKey(url),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final prompt = context.read<ImageBloc>().savedPrompt;
            context.read<ImageBloc>().add(GenerateImage(prompt));
          },
          child: const Text('Try another'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('New prompt'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Something went wrong.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final prompt = context.read<ImageBloc>().savedPrompt;
              context.read<ImageBloc>().add(GenerateImage(prompt));
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
