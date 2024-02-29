import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntervalInput extends StatelessWidget {
  const IntervalInput({
    super.key,
    required this.intervalloNotificheBere,
    required this.onIntervalChanged,
    required this.onSavePressed,
    required this.labelText,
    required this.intervalController,
  });

  final int intervalloNotificheBere;
  final ValueChanged<String> onIntervalChanged;
  final VoidCallback onSavePressed;
  final String labelText;
  final TextEditingController intervalController;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: intervalController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      cursorColor: Colors.blueGrey,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*$'), // Accept only numbers
                        ),
                      ],
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: const UnderlineInputBorder(),
                        labelText: labelText,
                        labelStyle: const TextStyle(fontSize: 14, color: Colors.black87),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.only(bottom: 6.0),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                      ),
                      onChanged: onIntervalChanged,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      int newInterval = int.tryParse(intervalController.text) ?? 0;
                      // Accept only values from 15 to 1440
                      if (newInterval >= 1 && newInterval <= 1440) {
                        onSavePressed();

                        // Show a success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Intervallo cambiato con successo'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 8.0,
                            action: SnackBarAction(
                              label: '✖',
                              textColor: Colors.white,
                              onPressed: () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                      } else {
                        // Show an error message
                        final snackBar = SnackBar(
                          content: const Text('Please enter a value between 15 minutes and 24 hours', textAlign: TextAlign.center),
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          behavior: SnackBarBehavior.floating,
                          elevation: 8.0,
                          action: SnackBarAction(
                            label: '✖',
                            textColor: Colors.white,
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save_outlined, color: Colors.white, size: 20),
                        SizedBox(width: 4.0),
                        Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



}
