import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatefulWidget {
  final Function(String) search;

  const SearchWidget({Key? key, required this.search}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      onChanged: widget.search,
      placeholder: 'search'.tr,
    );
  }
}
