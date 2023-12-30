import 'package:flutter/material.dart';

import '../../core/widgets/custom_will_pop_scope_widget.dart';
import '../../core/widgets/default_app_bar.dart';
import 'widgets/custom_bottom_nav_bar_widget.dart';
import 'widgets/result_body_widget.dart';
import 'widgets/shared_options_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomWillPopWidget(
      appBar: DefaultAppBar(),
      body: ResultBodyWidget(),
      bottomNavigationBar: CustomBottomNavBarWidget(),
      floatingActionButton: SharedOptionsWidget(),
    );
  }
}
