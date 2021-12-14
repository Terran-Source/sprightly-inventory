import 'package:dart_marganam/utils.dart';
import 'package:kiwi/kiwi.dart';
// import 'package:sprightly_inventory/core/config/app_config.dart';
import 'package:sprightly_inventory/core/config/constants.dart' as constants;
import 'package:sprightly_inventory/core/config/enums.dart';
import 'package:sprightly_inventory/core/widgets/error_popup.dart';

Future<bool> dispose({
  Environment environment = Environment.prod,
}) async {
  try {
    final kiwiContainer = KiwiContainer();

    // final configurations = kiwiContainer.resolve<AppConfig>();

    final initiates =
        kiwiContainer.resolve<List<Initiated>>(constants.coreInitiates);
    for (final initiate in initiates) {
      if (initiate is Disposable) {
        await (initiate as Disposable).dispose();
      }
    }

    // at last
    kiwiContainer.clear();

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
