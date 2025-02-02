import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
      body: Center(
        child: Text(
          'Optix Scouting\n'
          'Application by \n Paaras Purohit of Team Optix 3749\n\n'
          'Developer Team\n'
          'Paaras Purohit\n'
          'Aarush Gowda\n'
          'Neel Adem\n'
          'Tanav Kambhampati\n'
          'Aadi Bhat\n'
          'Solari Zhou\n'
          'Nick Diaz\n'
          'Aaryaa Jani\n'
          'Adam Ong\n'
          'Srinaga Pillutla\n'
          'Bridget Xiao',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}