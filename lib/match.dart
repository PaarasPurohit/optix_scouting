import 'package:flutter/material.dart';
import 'package:optix_scouting/data.dart';
import 'package:optix_scouting/save.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  int l1Score = 0;
  int l2Score = 0;
  int l3Score = 0;
  int l4Score = 0;
  int netShots = 0;
  int processorShots = 0;
  bool shallowSelected = false;
  bool parkSelected = false;
  bool deepSelected = false;
  bool defense = false;
  bool robotBroke = false;

  void _incrementCounter(Function(int) counter) {
    setState(() {
      counter(1);
    });
  }

  void _decrementCounter(Function(int) counter) {
    setState(() {
      counter(-1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Scouting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scores', style: TextStyle(fontSize: 18)),
            _buildCounter('L1', l1Score, (value) => l1Score += value),
            _buildCounter('L2', l2Score, (value) => l2Score += value),
            _buildCounter('L3', l3Score, (value) => l3Score += value),
            _buildCounter('L4', l4Score, (value) => l4Score += value),
            _buildCounter('Net Shots', netShots, (value) => netShots += value),
            _buildCounter('Processor Shots', processorShots, (value) => processorShots += value),
            SizedBox(height: 20),
            Text('Endgame', style: TextStyle(fontSize: 18)),
            _buildElevatedButton('Shallow', shallowSelected, () {
              setState(() {
                shallowSelected = !shallowSelected;
                parkSelected = false;
                deepSelected = false;
              });
            }),
            _buildElevatedButton('Park', parkSelected, () {
              setState(() {
                parkSelected = !parkSelected;
                shallowSelected = false;
                deepSelected = false;
              });
            }),
            _buildElevatedButton('Deep', deepSelected, () {
              setState(() {
                deepSelected = !deepSelected;
                shallowSelected = false;
                parkSelected = false;
              });
            }),
            SizedBox(height: 20),
            Text('Status', style: TextStyle(fontSize: 18)),
            _buildCheckbox('Defense', defense, (value) {
              setState(() {
                defense = value!;
              });
            }),
            _buildCheckbox('Robot Broke', robotBroke, (value) {
              setState(() {
                robotBroke = value!;
              });
            }),
            ElevatedButton(
              onPressed: () {
                DataStorage.storeScoutedData(l1Score, l2Score, l3Score, l4Score, netShots, processorShots, shallowSelected, parkSelected, deepSelected, defense, robotBroke);
                showSaveDialog(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int count, Function(int) counter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (count > 0) {
                  _decrementCounter(counter);
                }
              },
            ),
            Text(count.toString(), style: TextStyle(fontSize: 16)),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _incrementCounter(counter);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildElevatedButton(String label, bool selected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.green : Colors.grey,
      ),
      child: Text(label),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
