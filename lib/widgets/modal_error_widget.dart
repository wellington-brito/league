import 'package:flutter/material.dart';

class ModalErrorWidget extends StatelessWidget {
  final String? error;

  const ModalErrorWidget({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _showDialog(context);
  }

  _showDialog(context){
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error on Load data.',
                style: TextStyle(fontSize: 16)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    error.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
