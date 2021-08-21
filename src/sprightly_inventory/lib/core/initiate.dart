import 'package:dart_marganam/utils.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sprightly_inventory/core/config/app_config.dart';
import 'package:sprightly_inventory/core/config/constants.dart' as constants;
import 'package:sprightly_inventory/core/widgets/error_popup.dart';
import 'package:sprightly_inventory/data/constants/enums.dart';
import 'package:sprightly_inventory/data/initiate.dart' as db;

Future<bool> initiate([Environment environment = Environment.prod]) async {
  try {
    final initiates = <Initiated>[];
    final kiwiContainer = KiwiContainer();

    final configurations = await AppConfig.from(environment);

    initiates.add(ExceptionPackage());

    final remoteFileCache = RemoteFileCache();
    kiwiContainer.registerSingleton((container) => remoteFileCache);
    initiates.add(remoteFileCache);

    // initiate database
    initiates.addAll(await db.initiate(kiwiContainer,
        environment: environment, configurations: configurations));

    // await settingsInitiate.initiate(kiwiContainer,
    //     environment: environment, configurations: configurations);

    kiwiContainer.registerSingleton((container) => initiates,
        name: constants.initiates);
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
    showErrorPopup(FormattedException(
      e,
      stackTrace: st,
      moduleName: 'sprightly.initiate',
    ));
  }
  return false;
}
