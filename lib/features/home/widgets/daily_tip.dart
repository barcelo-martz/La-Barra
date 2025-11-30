import 'package:flutter/material.dart';

class DailyTip extends StatelessWidget {
  const DailyTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Consejos Diarios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Bienvenido a La Barra, tu rincón de coctelería\n¿Qué vas a preparar hoy?',
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}