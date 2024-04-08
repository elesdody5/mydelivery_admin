import 'package:core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../domain/model/debt.dart';

class DebtsDialog extends StatelessWidget {
  final Debt debt = Debt();
  final Function(Debt) addDebts;

  DebtsDialog({Key? key, required this.addDebts}) : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  void _submit() {
    try {
      if (_fbKey.currentState?.validate() == true) {
        _fbKey.currentState?.save();
        debt.createdAt = DateTime.now();
        Get.back();
        addDebts(debt);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("add_debts".tr),
      content: FormBuilder(
          key: _fbKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'title',
                  validator: FormBuilderValidators.required(),
                  onSaved: (String? title) => debt.title = title,
                  decoration: formInputDecoration(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'phone',
                  keyboardType: TextInputType.phone,
                  validator: FormBuilderValidators.required(),
                  onSaved: (String? phone) => debt.phone = phone,
                  decoration: formInputDecoration(label: "${"phone".tr} (${"optional".tr})" ),
                ),
              ),
            ],
          )),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
        TextButton(onPressed: _submit, child: Text("save".tr)),
      ],
    );
  }
}
