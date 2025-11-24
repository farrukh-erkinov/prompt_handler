import 'package:flutter_bloc/flutter_bloc.dart';
import 'image_event.dart';
import 'image_state.dart';
import '../services/mock_generator.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  String savedPrompt = '';

  ImageBloc() : super(ImageInitial()) {
    on<GenerateImage>((event, emit) async {
      savedPrompt = event.prompt;
      emit(ImageLoading());
      try {
        final url = await MockGenerator.generate(event.prompt);
        emit(ImageSuccess(url));
      } catch (e) {
        emit(ImageFailure(e.toString()));
      }
    });
  }
}
