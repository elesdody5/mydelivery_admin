import 'package:cool_alert/cool_alert.dart';
import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension NullSafeBlock<T> on T? {
  void let(Function(T it) runnable) {
    final instance = this;
    if (instance != null) {
      runnable(instance);
    }
  }
}

void setupErrorMessageListener(RxnString errorMessageKey) {
  ever(errorMessageKey, (String? message) {
    if (message != null) {
      showErrorDialog(message.tr);
      errorMessageKey.clear();
    }
  });
}

void setupSuccessMessageListener(RxnString successMessage) {
  ever(successMessage, (String? message) {
    if (message != null) {
      showSuccessDialog(message.tr);
      successMessage.clear();
    }
  });
}

void showSuccessDialog(String message) {
  CoolAlert.show(
      context: Get.context!, type: CoolAlertType.success, text: message);
}

void setupLoadingListener(RxBool isLoading) {
  ever(isLoading, (bool isLoading) {
    isLoading ? showLoadingProgress() : hideLoadingProgress();
  });
}

void setupNavigationListener(Rxn<NavigationDestination> navigationObs) {
  ever(navigationObs, (NavigationDestination? navigation) {
    navigation?.let((it) {
      navigation.removeFromStack == true
          ? Get.offNamed(it.routeName, arguments: navigation.argument)
          : Get.toNamed(it.routeName, arguments: navigation.argument);
      navigationObs.clear();
    });
  });
}

void showErrorDialog(String message) {
  CoolAlert.show(
    context: Get.context!,
    type: CoolAlertType.error,
    text: message,
  );
}

void showLoadingProgress() {
  CoolAlert.show(
    context: Get.context!,
    type: CoolAlertType.loading,
  );
}

void hideLoadingProgress() {
  Get.back();
}

extension FormtDate on DateTime {
  String customFormat() {
    final df = DateFormat('dd/MM/yyyy');
    return df.format(this);
  }

  String timeFormat() {
    String formattedDate = DateFormat.jm().format(this);
    String am = "am".tr;
    String pm = "pm".tr;
    formattedDate = formattedDate.replaceAll("AM", am);
    formattedDate = formattedDate.replaceAll("PM", pm);
    return formattedDate;
  }
}

/// The day of the week [monday]..[sunday].
///
/// In accordance with ISO 8601
/// a week starts with Monday, which has the value 0.
///
String getDayLocal(int day) {
  var days = "days".tr.split(",");
  return days[day];
}
