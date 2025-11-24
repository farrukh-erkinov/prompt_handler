abstract class ImageEvent {}

class GenerateImage extends ImageEvent {
  final String prompt;
  GenerateImage(this.prompt);
}
