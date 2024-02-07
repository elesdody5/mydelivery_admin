import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:provider/provider.dart';
import '../domain/model/debt.dart';
import 'debts_provider.dart';
import 'widgets/debts_dialog.dart';
import 'widgets/debts_list_item.dart';

class DebtsScreen extends StatelessWidget {
  const DebtsScreen({Key? key}) : super(key: key);

  void _setupListener(DebtsProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
  }

  void _showAlertDialog(DebtsProvider provider, Debt debt) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.removeDebt(debt);
          },
          child: Text("yes".tr),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("cancel".tr),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DebtsProvider>(context, listen: false);
    _setupListener(provider);
    return Scaffold(
        appBar: AppBar(
          title: Text("debts".tr),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Get.dialog(DebtsDialog(addDebts: provider.addDebt)),
            child: const Icon(Icons.add)),
        body: FutureWithLoadingProgress(
            future: provider.getAllDebts,
            child: Consumer<DebtsProvider>(
              builder: (_, provider, child) => ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                      ),
                  itemCount: provider.debts.length,
                  itemBuilder: (context, index) => DebtsListItem(
                      debt: provider.debts[index],
                      onLongPress: (debt) => _showAlertDialog(provider, debt))),
            )));
  }
}
