import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Dialogs {
  static Future<void> alert(BuildContext context,
      {String? title, String? content, String okText = "OK"}) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: title != null
            ? Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        content: content != null
            ? SizedBox(
                width: 30,
                height: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(content),
                  ],
                ),
              )
            : null,
        actions: [
          Center(
            child: ElevatedButton(
                onPressed: () => Navigator.pop(_),
                child: Text(
                  okText,
                )),
          ),
        ],
      ),
    );
  }
}
