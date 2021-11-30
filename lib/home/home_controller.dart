import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision/models/image_model.dart';

class HomeController {
  final ImagePicker _imagePicker = ImagePicker();
  ImageModel? image;
  String resultado = "";
  List<String> labels = <String>[];

  Future<void> getImageCamera() async {
    try {
      final _image = await _imagePicker.pickImage(source: ImageSource.camera);
      image = ImageModel(imagePath: _image!.path);

      if (image != null) {
        await TextRecognitor(image!.imagePath!);
      }
      return;
    } catch (erro) {
      print("Erro ao tentar abrir camera!" + erro.toString());
    }
  }

  Future<void> getImageGalery() async {
    try {
      final _image = await _imagePicker.pickImage(source: ImageSource.gallery);
      image = ImageModel(imagePath: _image!.path);

      if (image != null) {
        await TextRecognitor(image!.imagePath!);
      }
      return;
    } catch (erro) {
      print("Erro ao tentar abrir camera!" + erro.toString());
    }
  }

  Future<void> TextRecognitor(String path) async {
    resultado = "";
    labels = <String>[];
    RegExp dateRegex = RegExp(
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$');
    RegExp moneyRegex = RegExp(r"^[1-9]\d{0,2}(\.\d{3})*,\d{2}$");

    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetectorV2();

    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine item in block.lines) {
        labels.add(item.text);
        // if (dateRegex.hasMatch(item.text) || moneyRegex.hasMatch(item.text)) {
        //   labels.add(item.text);
        // }
      }
    }
  }
}
