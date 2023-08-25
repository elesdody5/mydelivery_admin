import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:dashboard/cities/cities_dialog_provider.dart';
import 'package:core/domain/city.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:widgets/future_with_loading_progress.dart';

class CitiesDialog extends StatelessWidget {
  CitiesDialog({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _setupListener(CitiesDialogProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupSuccessMessageListener(provider.successMessage);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CitiesDialogProvider>(context, listen: false);
    _setupListener(provider);
    return AlertDialog(
        title: Text("cities_out_menouf".tr),
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  _formKey.currentState?.save();
                  Get.back();
                  provider.addNewCity();
                }
              },
              child: Text("confirm".tr)),
          TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
        ],
        content: FutureWithLoadingProgress(
          future: provider.getCities,
          child: FormBuilder(
              key: _formKey,
              child:
                  Consumer<CitiesDialogProvider>(builder: (_, provider, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderDropdown<City>(
                        name: "city",
                        decoration: formInputDecoration(label: "city".tr),
                        onChanged: (City? city) {
                          if (city != null) {
                            provider.currentCity = city;
                            _nameController.text = city.name ?? "";
                            _priceController.text = city.price.toString() ?? "";
                          }
                        },
                        onSaved: (City? city) {
                          if (city != null) {
                            provider.currentCity = city;
                          }
                        },
                        items: provider.cities
                            .map((city) => DropdownMenuItem(
                                  value: city,
                                  child: Text(city.name ?? ""),
                                ))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                          name: "city_name",
                          controller: _nameController,
                          onSaved: (String? name) {
                            if (name != null) {
                              provider.currentCity.name = name;
                            }
                          },
                          decoration: formInputDecoration(label: "name".tr),
                          validator: FormBuilderValidators.required(
                              errorText: "please_enter_name".tr)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                          name: "city_price",
                          controller: _priceController,
                          onSaved: (String? price) {
                            provider.currentCity.price =
                                num.tryParse(price ?? "0");
                          },
                          keyboardType: TextInputType.number,
                          decoration: formInputDecoration(label: "price".tr),
                          validator: FormBuilderValidators.required(
                              errorText: "price".tr)),
                    )
                  ],
                );
              })),
        ));
  }
}
