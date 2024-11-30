import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/check/repositories/check_repository.dart';
import '../../../domain/check/services/check_sharing_service.dart';
import '../../../domain/check/usecases/create_check.dart';
import '../../../domain/check/usecases/share_check.dart';
import '../../../external/check/datasourcers/sqflite_check_datasource.dart';
import '../../../external/services/cache/shared_preferences_cache_service.dart';
import '../../../external/services/generate_check_service_impl.dart';
import '../../../external/services/share_plus_service_impl.dart';
import '../../../infra/check/repositories/check_repository_impl.dart';
import '../../../infra/check/datasourcers/local_check_datasource.dart';
import '../../../infra/services/cache/cache_service.dart';
import '../../../infra/check/services/check_sharing_service_impl.dart';
import '../../../infra/services/generate_check_service.dart';
import '../../../infra/services/share_service.dart';
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
          Provider<GenerateCheckService>(
            create: (_) => GenerateCheckServiceImpl(),
          ),
          Provider<ShareService>(
            create: (_) => SharePlusCheckServiceImpl(),
          ),
          Provider<CheckSharingService>(
            create: (context) => CheckSharingServiceImpl(
              generateCheckService: context.read<GenerateCheckService>(),
              shareCheckService: context.read<ShareService>(),
            ),
          ),
          Provider<ShareCheck>(
            create: (context) => ShareCheckImpl(
              sharingService: context.read<CheckSharingService>(),
            ),
          ),
          Provider<CreateCheck>(
            create: (context) => CreateCheckImpl(
              repository: context.read<CheckRepository>(),
            ),
          ),
          ChangeNotifierProvider<CheckController>(
            create: (context) => CheckController(
              shareCheck: context.read<ShareCheck>(),
              createCheck: context.read<CreateCheck>(),
              repository: context.read<CheckRepository>(),
            ),
          ),
        ],
        child: child,
      );
}
