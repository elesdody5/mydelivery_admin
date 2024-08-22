import 'package:core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class UserPhoneWidget extends StatefulWidget {
  final void Function(String) onSave;
  final void Function(String) onDelete;
  final String? phone;

  const UserPhoneWidget(
      {Key? key, this.phone, required this.onSave, required this.onDelete})
      : super(key: key);

  @override
  State<UserPhoneWidget> createState() => _UserPhoneWidgetState();
}

class _UserPhoneWidgetState extends State<UserPhoneWidget> {
  final TextEditingController _controller = TextEditingController();
  String? value;
  bool _validate = true;

  @override
  void initState() {
    value = widget.phone;
    super.initState();
  }

  Widget saveIcon() => IconButton(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        onPressed: () {
          if (_controller.value.text.length == 11) {
            widget.onSave(_controller.value.text);
            setState(() {
              value = _controller.value.text;
            });
          } else {
            setState(() {
              _validate = false;
            });
          }
        },
      );

  Widget deleteIcon() => IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
        onPressed: () {
          if (value != null) widget.onDelete(value!);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 4,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                enabled: value?.isNotEmpty == true,
                decoration: formInputDecoration(
                    label: "phone".tr,
                    errorText:
                        !_validate ? "please_enter_valid_phone".tr : null),
              )),
        ),
        // Flexible(
        //   flex: 1,
        //   child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: value?.isNotEmpty == true ? deleteIcon() : saveIcon()),
        // ),
      ],
    );
  }
}
