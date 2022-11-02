import 'package:flutter/material.dart';

import '../constants/app_utlis.dart';

class CustomAppBar extends StatelessWidget {
  final TextEditingController filterListController;
  final Function(String) onSearchTextChanged;
  const CustomAppBar(
      {Key? key,
      required this.filterListController,
      required this.onSearchTextChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: UtilHelper.autoCompleteFeature(
                  controller: filterListController,
                  onChangedFunction: onSearchTextChanged)),
        ],
      ),
    );
  }
}
