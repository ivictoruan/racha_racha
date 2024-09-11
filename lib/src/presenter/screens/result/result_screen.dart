import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/custom_will_pop_scope_widget.dart';
import '../../../infra/services/generate_check_service.dart';
import '../../../infra/services/share_check_service.dart';
import 'widgets/custom_bottom_nav_bar_widget.dart';
import 'widgets/result_body_widget.dart';
import 'widgets/shared_options_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomWillPopWidget(
      body: const ResultBodyWidget(),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
      floatingActionButton: SharedCheckOptionsWidget(
        generateImageService: context.read<GenerateCheckService>(),
        shareService: context.read<ShareCheckService>(),
      ),
    );
  }
}
