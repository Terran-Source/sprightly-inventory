import 'package:dart_marganam/utils/exceptions/exceptions.dart';
import 'package:dart_marganam/utils/file_provider.dart';
import 'package:dart_marganam/utils/formatted_exception.dart';
import 'package:dart_marganam/utils/initiated.dart';
import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sprightly_inventory/core/config/app_config.dart';
import 'package:sprightly_inventory/core/config/constants.dart' as constants;
import 'package:sprightly_inventory/core/config/enums.dart';
import 'package:sprightly_inventory/core/widgets/error_popup.dart';
import 'package:sprightly_inventory/data/initiate.dart' as data;

Future<bool> initiate({Environment environment = Environment.prod}) async {
  try {
    final initiates = <Initiated>[];
    final kiwiContainer = KiwiContainer();

    final configurations = await AppConfig.of(environment: environment);
    kiwiContainer.registerSingleton((container) => configurations);

    initiates.add(ExceptionPackage());
    if (!kIsWeb) {
      final remoteFileCache = RemoteFileCache();
      kiwiContainer.registerSingleton((container) => remoteFileCache);
      initiates.add(remoteFileCache);
    }

    // initiate database
    initiates.addAll(
      await data.initiate(
        kiwiContainer,
        configurations,
        environment: environment,
      ),
    );

    // await settingsInitiate.initiate(kiwiContainer,
    //     environment: environment, configurations: configurations,);

    kiwiContainer.registerSingleton(
      (container) => initiates,
      name: constants.coreInitiates,
    );
    for (final initiator in initiates) {
      await initiator.initiate();
    }

    // final appDetails = kiwiContainer<AppDetails>();
    // FormattedException.appName = appDetails.appName;
    // final appSettings = kiwiContainer<AppSettings>();
    // FormattedException.debug = appSettings.debug;

    return true;
  } on FormattedException catch (e) {
    showErrorPopup(e);
  } on Exception catch (e, st) {
    showErrorPopup(
      FormattedException(
        e,
        stackTrace: st,
        moduleName: 'sprightly.initiate',
      ),
    );
  }
  return false;
}
