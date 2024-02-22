import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntervalInput extends StatelessWidget {
  const IntervalInput({
    Key? key,
    required this.intervalloNotificheBere,
    required this.onIntervalChanged,
    required this.onSavePressed,
    required this.labelText,
  }) : super(key: key);

  final int intervalloNotificheBere;
  final ValueChanged<String> onIntervalChanged;
  final VoidCallback onSavePressed;
  final String labelText;

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
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      cursorColor: Colors.blueGrey,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*$'), // Accetta solo numeri
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
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (intervalloNotificheBere != 0) {
                        onSavePressed();
                      } else {
                        // Mostra una notifica d'errore
                        final snackBar = SnackBar(
                          content: const Text('Attenzione! L\'intervallo delle notifiche non può essere 0', textAlign: TextAlign.center),
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          behavior: SnackBarBehavior.floating,
                          elevation: 8.0,
                          action: SnackBarAction(
                            label: 'Chiudi',
                            textColor: Colors.white,
                            onPressed: () {
                              // Azione da eseguire quando si preme il pulsante Chiudi
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
                          'Salva',
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
