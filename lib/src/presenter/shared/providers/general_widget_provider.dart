import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/check/repositories/check_repository.dart';
import '../../../external/check/datasourcers/sqflite_check_datasource.dart';
import '../../../external/services/cache/shared_preferences_cache_service.dart';
import '../../../infra/check/check_repository_impl.dart';
import '../../../infra/check/datasourcers/local_check_datasource.dart';
import '../../../infra/services/cache/cache_service.dart';
import '../controllers/check_controller.dart';
import '../controllers/user_controller.dart';

class GeneralWidgetProvider extends StatelessWidget {
  final Widget child;
  const GeneralWidgetProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<CacheService>(
            create: (_) => SharedPreferencesCacheService(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserController(),
          ),
          Provider<LocalCheckDatasource>(
            create: (context) => SqfliteCheckDatasource(),
          ),
          Provider<CheckRepository>(
            create: (context) => CheckRepositoryImpl(
              localDatasource: context.read<LocalCheckDatasource>(),
            ),
          ),
          ChangeNotifierProvider<CheckController>(
            create: (context) => CheckController(
              repository: context.read<CheckRepository>(),
            ),
          ),
        ],
        child: child,
      );
}
