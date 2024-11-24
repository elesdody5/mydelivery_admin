import 'package:core/domain/user.dart';
import 'package:core/domain/user_city.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

class CitiesDropdownButton extends StatefulWidget {
  final Function(UserCity?) onChanged;
  final List<UserCity> userCities;

  const CitiesDropdownButton(
      {Key? key, required this.onChanged, required this.userCities})
      : super(key: key);

  @override
  State<CitiesDropdownButton> createState() => _TypeFilterButtonState();
}

class _TypeFilterButtonState extends State<CitiesDropdownButton> {
  UserCity? currentValue;

  void onChanged(value) {
    setState(() {
      currentValue = value;
      widget.onChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<UserCity?>(
      value: currentValue,
      menuWidth: 163,
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      underline: const SizedBox.shrink(),
      borderRadius: BorderRadius.circular(16),
      dropdownColor: Get.theme.cardColor,
      items: [
        ...widget.userCities.map(
          (e) => DropdownMenuItem(
            value: e,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              // Align radio to the right
              children: [
                Text(e.name?.capitalizeFirst ?? ""),
              ],
            ),
          ),
        )
      ],
      onChanged: onChanged,
    );
  }
}
