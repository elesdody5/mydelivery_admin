import 'package:cool_alert/cool_alert.dart';
import 'package:core/model/offer.dart';
import 'package:core/screens.dart';
import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'offer_details_provider.dart';
import 'widgets/offer_image_picker.dart';

class OfferDetailsScreen extends StatefulWidget {
  static String routeName = "/offer_details";

  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool isInit = true;
  late OfferDetailsProvider provider;

  @override
  void didChangeDependencies() async {
    if (isInit) {
      Offer? offer = Get.arguments;
      provider = Provider.of<OfferDetailsProvider>(context, listen: false);
      if (offer != null) provider.initOffer(offer);
      _setupListener();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  void _setupListener() {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    _setupSuccessMessageListener(provider.successMessage);
  }

  void _setupSuccessMessageListener(RxnString successMessage) {
    ever(successMessage, (String? message) {
      CoolAlert.show(
        context: Get.context!,
        type: CoolAlertType.success,
        text: message?.tr,
        confirmBtnText: "continue".tr,
        onConfirmBtnTap: () =>
            Get.offNamedUntil(homeScreen, (route) => false),
      );
    });
  }

  void _submit() {
    if (_fbKey.currentState?.validate() == false) return;
    _fbKey.currentState?.save();
    provider.addOrUpdateOffer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add_offer".tr),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          child:
              Consumer<OfferDetailsProvider>(builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OfferImagePicker(
                  onImageSelected: provider.onImageSelected,
                  selectedImage: provider.offer.imageFile,
                  imageUrl: provider.offer.photo,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderTextField(
                      name: "description",
                      initialValue: provider.offer.description,
                      onSaved: (String? description) {
                        provider.offer.description = description;
                      },
                      decoration: formInputDecoration(label: "description".tr),
                      validator: FormBuilderValidators.required(
                        context,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: _submit,
                      child: Text(
                        "save".tr,
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
