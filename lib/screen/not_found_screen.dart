import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '404',
              style: GoogleFonts.manrope(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Oops! No hay nada aquí',
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Regresar',
                  style: GoogleFonts.manrope(),
                ))
          ],
        ),
      ),
    );
  }
}
