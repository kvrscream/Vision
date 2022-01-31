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
    RegExp dateRegex = RegExp(r'\\d{2}\\/\\d{2}\\/\\d{4}');
    RegExp moneyRegex = RegExp(r"[1-9]\d{0,2}(\.\d{3})*,\d{2}$");

    RegExp cnpjRegex =
        RegExp(r'[0-9]{2}\.?[0-9]{3}\.?[0-9]{3}\/?[0-9]{4}\-?[0-9]{2}');

    RegExp cpfRegex = RegExp(r'[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}');

    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetector();

    try {
      final RecognisedText recognisedText =
          await textDetector.processImage(inputImage);

      for (TextBlock block in recognisedText.blocks) {
        for (TextLine item in block.lines) {
          if (cnpjRegex.hasMatch(item.text)) {
            labels.add("CNPJ: " + item.text);
          }

          if (cpfRegex.hasMatch(item.text)) {
            labels.add("CPF: " + item.text);
          }

          if (dateRegex.hasMatch(item.text)) {
            labels.add("Data: " + item.text);
          }

          if (moneyRegex.hasMatch(item.text)) {
            labels.add("Valor: " + item.text);
          }
        }
      }

      return;
    } catch (erro) {
      print("Erro TxtRecognition " + erro.toString());
    }
  }
}
