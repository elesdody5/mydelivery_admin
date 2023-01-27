import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatefulWidget {
  final Function(String) search;
  final String? hint;

  const SearchWidget({Key? key, required this.search, this.hint})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      onChanged: widget.search,
      placeholder: widget.hint ?? 'search'.tr,
    );
  }
}
