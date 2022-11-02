import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class UtilHelper {
  UtilHelper._();

  static Color appColor = Colors.blue.shade600;

  static Widget autoCompleteFeature(
          {double paddingHorizontal = 10.0,
          double paddingVertical = 10.0,
          double borderRadius = 10.0,
          required TextEditingController controller,
          String hintText = "Type Something To Search...",
          bool isPrefix = false,
          Widget? prefixIcon,
          var onChangedFunction}) =>
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          children: [
            isPrefix
                ? prefixIcon!
                : const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
            Expanded(
                child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: controller,
              decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  )),
              onChanged: onChangedFunction,
            ))
          ],
        ),
      );

  static Widget sizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 5,
      width: width ?? 5,
    );
  }

  static appTextStyle({Color? color, double? size, FontWeight? fontWeight}) {
    return TextStyle(
        color: color ?? Colors.black,
        fontSize: size ?? 15.0,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static mainHeadingTextWidget(
      {String? text, Color? color, FontWeight? fontWeight}) {
    return AutoSizeText(
      text ?? "",
      minFontSize: 9,
      maxLines: 12,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? Colors.red,
          fontSize: 25,
          fontWeight: fontWeight ?? FontWeight.bold),
    );
  }

  static headingTextWidget(
      {String? text, Color? color, FontWeight? fontWeight}) {
    return AutoSizeText(
      text ?? "",
      minFontSize: 9,
      maxLines: 12,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? Colors.green,
          fontWeight: fontWeight ?? FontWeight.bold),
    );
  }

  static normalTextWidget(
      {String? text, Color? color, FontWeight? fontWeight}) {
    return AutoSizeText(
      text ?? "",
      minFontSize: 9,
      maxLines: 12,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color ?? Colors.red,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }

  static bool getInternetConnection(Map _source) {
    bool isConnected = true;
    if (_source.keys.toList()[0] == ConnectivityResult.mobile) {
      isConnected = true;
      return isConnected;
    } else if (_source.keys.toList()[0] == ConnectivityResult.wifi) {
      isConnected = true;
      return isConnected;
    } else if (_source.keys.toList()[0] == ConnectivityResult.none) {
      isConnected = false;
      return isConnected;
    } else {
      isConnected = true;
      return isConnected;
    }
  }
}
