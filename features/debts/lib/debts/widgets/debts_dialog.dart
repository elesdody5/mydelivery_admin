import 'package:core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:core/domain/PhoneContact.dart';

import '../../domain/model/debt.dart';

class DebtsDialog extends StatelessWidget {
  final Debt debt = Debt();
  final Function(Debt) addDebts;
  final List<PhoneContact> phoneContacts;
  DebtsDialog({Key? key, required this.addDebts, required this.phoneContacts}) : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _phoneController = TextEditingController();

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
                  child: TypeAheadFormField<PhoneContact>(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration:
                      formInputDecoration(label: 'phone'.tr),
                      controller: _phoneController,
                    ),
                    onSuggestionSelected: (PhoneContact contact) {
                      _phoneController.text = contact.number;
                    },
                    onSaved: (String? value) => debt.phone = value,
                    itemBuilder: (BuildContext context,
                        PhoneContact contact) {
                      return ListTile(
                        title: Text(contact.name),
                        subtitle: Text(contact.number),
                      );
                    },
                    suggestionsCallback: (pattern) {
                      return phoneContacts.where(
                              (contact) => contact.name
                              .toLowerCase()
                              .contains(pattern.toLowerCase()));
                    },
                  )),
            ],
          )),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
        TextButton(onPressed: _submit, child: Text("save".tr)),
      ],
    );
  }
}
