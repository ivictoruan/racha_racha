import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../domain/check/entities/check_model.dart';
import '../../infra/services/generate_check_service.dart';

/// A service implementation responsible for generating an image of a check.
///
/// The class `GenerateCheckServiceImpl` implements the `GenerateCheckService`
/// interface and is responsible for drawing the header, content, and footer of a check
/// based on the `CheckModel` provided. It uses Flutter's low-level canvas APIs
/// to render the check design.
///
/// The generated check includes a header with a title and subtitle,
/// a content area that displays the check summary (total value, tip, and individual share),
/// and a footer with promotional information.
///
/// The generated image is returned as a `Uint8List` for further use, such as saving or sharing.
class GenerateCheckServiceImpl implements GenerateCheckService {
  late ui.Canvas _canvas;
  late ui.Size _size;
  late MaterialColor _baseColor;
  late Color _backgroundColor;
  late Color _headerColor;
  late Color _textColor;

  @override
  Future<Uint8List> generateImage({required CheckModel check}) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    _canvas = Canvas(recorder);
    _size = const Size(800, 700);

    _setupColors();
    _drawBackground();
    _drawHeader();
    _drawContent(check);
    _drawFooter();

    return _finalizeImage(recorder);
  }

  void _setupColors() {
    _baseColor = Colors.deepPurple;
    _backgroundColor = _baseColor.shade50;
    _headerColor = _baseColor.shade700;
    _textColor = _baseColor.shade900;
  }

  void _drawBackground() {
    final ui.Paint bgPaint = Paint()..color = _backgroundColor;
    _canvas.drawRect(Rect.fromLTWH(0, 0, _size.width, _size.height), bgPaint);
  }

  void _drawHeader() {
    final ui.Paint headerPaint = Paint()..color = _headerColor;
    _canvas.drawRect(Rect.fromLTWH(0, 0, _size.width, 150), headerPaint);

    _drawText('Racha Racha', 30, 50,
        color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold);
    _drawText('Seu app de dividir a conta no rolê!', 30, 110,
        color: Colors.white, fontSize: 24);
  }

  void _drawContent(CheckModel check) {
    final double totalValueWithoutWaiterValue =
        check.totalValue - check.totalWaiterValue;

    _drawText('Resumo da Conta', 30, 180,
        fontSize: 36, fontWeight: FontWeight.bold);

    double yOffset = 240;
    _drawRow('Total da Conta:', 'R\$ ${check.totalValue.toStringAsFixed(2)}',
        yOffset);
    yOffset += 60;
    _drawRow('Total sem Gorjeta:',
        'R\$ ${totalValueWithoutWaiterValue.toStringAsFixed(2)}', yOffset);
    yOffset += 60;
    _drawRow('Gorjeta:', 'R\$ ${check.totalWaiterValue.toStringAsFixed(2)}',
        yOffset);
    yOffset += 60;

    if (check.isSomeoneDrinking) {
      _drawRow('Valor p/ quem não bebeu:',
          'R\$ ${check.individualPrice.toStringAsFixed(2)}', yOffset);
      yOffset += 60;
      _drawRow(
          'Valor p/ quem bebeu:',
          'R\$ ${check.individualPriceWhoIsDrinking.toStringAsFixed(2)}',
          yOffset);
    } else {
      _drawRow('Valor Individual:',
          'R\$ ${check.individualPrice.toStringAsFixed(2)}', yOffset);
    }
  }

  void _drawFooter() {
    final ui.Paint footerPaint = Paint()..color = _headerColor;
    _canvas.drawRect(
        Rect.fromLTWH(0, _size.height - 100, _size.width, 100), footerPaint);

    _drawText('Baixe o Racha Racha', 30, _size.height - 70,
        color: Colors.white, fontSize: 20);
  }

  void _drawText(
    String text,
    double x,
    double y, {
    Color? color,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign align = TextAlign.left,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
            color: color ?? _textColor,
            fontSize: fontSize,
            fontWeight: fontWeight),
      ),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );

    textPainter.layout(maxWidth: maxWidth);

    final ui.Offset offset = align == TextAlign.right
        ? Offset(x - textPainter.width, y)
        : Offset(x, y);

    textPainter.paint(_canvas, offset);
  }

  void _drawRow(String label, String value, double y) {
    _drawText(label, 30, y, fontSize: 22, maxWidth: _size.width * 0.6);
    _drawText(value, _size.width - 30, y,
        fontSize: 22, align: TextAlign.right, maxWidth: _size.width * 0.4);
  }

  Future<Uint8List> _finalizeImage(ui.PictureRecorder recorder) async {
    final ui.Picture picture = recorder.endRecording();
    final ui.Image img =
        await picture.toImage(_size.width.toInt(), _size.height.toInt());
    final ByteData? pngBytes =
        await img.toByteData(format: ui.ImageByteFormat.png);
    return pngBytes!.buffer.asUint8List();
  }
}
