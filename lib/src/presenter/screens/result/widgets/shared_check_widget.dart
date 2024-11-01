import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../domain/check/entities/check_model.dart';
import '../../../../infra/services/generate_check_service.dart';
import '../../../../infra/services/share_check_service.dart';

class SharedCheckWidget extends StatelessWidget {
  final ShareCheckService shareService;
  final GenerateCheckService generateImageService;
  final CheckModel check;

  const SharedCheckWidget({
    Key? key,
    required this.check,
    required this.shareService,
    required this.generateImageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.deepPurpleAccent,
        color: Colors.white,
        child: FloatingActionButton.extended(
          focusColor: const Color.fromARGB(255, 247, 243, 247),
          backgroundColor: Colors.white,
          icon: const Icon(Icons.share, color: Colors.deepPurple),
          label: Text(
            "Compartilhar",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          onPressed: () async => await _onShareCheck(
            check: check,
          ),
        ),
      );

  Future<void> _onShareCheck({required CheckModel check}) async {
    await generateImageService
        .generateImage(
          check: check,
        )
        .then(
          (Uint8List image) async => await shareService.shareCheck(
            imageBytes: image,
          ),
        );
  }
}
