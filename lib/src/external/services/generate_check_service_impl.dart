import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../domain/check/entities/check.dart';
import '../../infra/services/generate_check_service.dart';

class GenerateCheckServiceImpl implements GenerateCheckService {
  late ui.Canvas _canvas;
  late ui.Size _size;
  late MaterialColor _baseColor;
  late Color _backgroundColor;
  late Color _headerColor;
  late Color _textColor;

  @override
  Future<Uint8List> generateImage({required Check check}) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    _canvas = Canvas(recorder);

    final double contentHeight = 150.0 +
        100.0 +
        60.0 +
        (check.participants.length * 45.0) +
        60.0 +
        (check.items.length * 60.0) +
        140.0;
    final double totalHeight = contentHeight.clamp(700.0, 5000.0);
    _size = Size(800, totalHeight);

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

    _drawText('Racha Racha', 30, 45,
        color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold);
    _drawText('Divisão da Conta', 30, 100,
        color: Colors.white.withValues(alpha: 0.9), fontSize: 22);
  }

  void _drawContent(Check check) {
    double yOffset = 180;

    _drawText(
      'Detalhes da Divisão',
      30,
      yOffset,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: _baseColor.shade900,
    );
    yOffset += 45;

    // Card de Valor Total
    final ui.Paint cardPaint = Paint()
      ..color = Colors.deepPurple.shade100.withValues(alpha: 0.6);
    final RRect totalRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(30, yOffset, _size.width - 60, 50),
      const Radius.circular(12),
    );
    _canvas.drawRRect(totalRRect, cardPaint);
    _drawText(
      '💰 Valor Total da Conta:',
      45,
      yOffset + 12,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: _baseColor.shade900,
    );
    _drawText(
      'R\$ ${check.totalValue.toStringAsFixed(2).replaceAll('.', ',')}',
      _size.width - 45,
      yOffset + 10,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      align: TextAlign.right,
      color: _baseColor.shade800,
    );
    yOffset += 75;

    // Seção Participantes
    if (check.participants.isNotEmpty) {
      _drawText(
        '👥 Participantes (${check.participants.length}):',
        30,
        yOffset,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _baseColor.shade800,
      );
      yOffset += 38;

      for (final participant in check.participants) {
        _drawRow(
          '• ${participant.name}',
          'Deve: R\$ ${participant.total.toStringAsFixed(2).replaceAll('.', ',')}',
          yOffset,
          isWithDollarSign: false,
        );
        yOffset += 36;
      }
      yOffset += 20;
    }

    // Seção Itens
    if (check.items.isNotEmpty) {
      _drawText(
        '🛒 Itens Consumidos (${check.items.length}):',
        30,
        yOffset,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: _baseColor.shade800,
      );
      yOffset += 38;

      for (final item in check.items) {
        final consumersText = item.consumers.isNotEmpty
            ? item.consumers.map((c) => c.name).join(', ')
            : 'Nenhum participante';

        _drawRow(
          '• ${item.name}',
          'R\$ ${item.price.toStringAsFixed(2).replaceAll('.', ',')}',
          yOffset,
          isWithDollarSign: false,
        );
        yOffset += 26;

        _drawText(
          '   Consumido por: $consumersText',
          30,
          yOffset,
          fontSize: 16,
          color: Colors.grey.shade700,
          maxWidth: _size.width - 60,
        );
        yOffset += 34;
      }
    }
  }

  void _drawFooter() {
    final ui.Paint footerPaint = Paint()..color = _headerColor;
    _canvas.drawRect(
      Rect.fromLTWH(0, _size.height - 80, _size.width, 80),
      footerPaint,
    );

    _drawText(
      'Racha Racha - Seu app de dividir a conta no rolê!',
      30,
      _size.height - 50,
      color: Colors.white,
      fontSize: 18,
    );
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
          fontWeight: fontWeight,
        ),
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

  void _drawRow(
    String label,
    String value,
    double y, {
    bool isWithDollarSign = true,
  }) {
    _drawText(
      label,
      30,
      y,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      maxWidth: _size.width * 0.6,
    );
    _drawText(
      isWithDollarSign ? 'R\$ $value' : value,
      _size.width - 30,
      y,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      align: TextAlign.right,
      maxWidth: _size.width * 0.4,
    );
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
