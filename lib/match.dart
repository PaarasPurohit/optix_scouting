import 'dart:async';
import 'package:flutter/material.dart';
import 'package:optix_scouting/save.dart';
import 'package:optix_scouting/data.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  int l1Score = 0, l2Score = 0, l3Score = 0, l4Score = 0;
  int netShots = 0, processorShots = 0;
  bool shallowSelected = false, parkSelected = false, deepSelected = false;
  bool defense = false, robotBroke = false;

  int autoTime = 15;
  int teleopTime = 5;
  bool isAuto = true;
  bool isRunning = false;
  late Timer _timer;

  void startTimer() {
    if (isRunning) return;

    setState(() {
      isRunning = true;
      isAuto = true;
      autoTime = 15;
      teleopTime = 5;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (isAuto && autoTime > 0) {
          autoTime--;
        } else if (isAuto && autoTime == 0) {
          isAuto = false; // Switch to Tele-Op
          DataStorage.l1ScoreAuto = l1Score;
          DataStorage.l2ScoreAuto = l2Score;
          DataStorage.l3ScoreAuto = l3Score;
          DataStorage.l4ScoreAuto = l4Score;
          DataStorage.netShotsAuto = netShots;
          DataStorage.processorShotsAuto = processorShots;
          resetTimer();
        } else if (!isAuto && teleopTime > 0) {
          teleopTime--;
        } else {
          _timer.cancel();
          isRunning = false;
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
        l1Score = 0;
        l2Score = 0;
        l3Score = 0;
        l4Score = 0;
        netShots = 0;
        processorShots = 0;
        shallowSelected = false;
        parkSelected = false;
        deepSelected = false;
        defense = false;
        robotBroke = false;
    });
  }

  Widget buildTimerUI() {
    return Column(
      children: [
        Text(
          isAuto ? "Auto: $autoTime s" : "Tele-Op: $teleopTime s",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: startTimer,
          style: ElevatedButton.styleFrom(
            backgroundColor: isRunning ? Colors.grey : Colors.blue,
          ),
          child: Text(isRunning ? "Running..." : "Start Timer"),
        ),
      ],
    );
  }

  Widget _buildCounter(String label, int count, Function(int) counter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(icon: Icon(Icons.remove), onPressed: () => setState(() => counter(-1))),
            Text(count.toString(), style: TextStyle(fontSize: 18)),
            IconButton(icon: Icon(Icons.add), onPressed: () => setState(() => counter(1))),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.cyan : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text),
    );
  }

  Widget _buildCheckbox(String text, bool value, Function(bool?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Checkbox(value: value, onChanged: onChanged, activeColor: Colors.green),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Match Scouting')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTimerUI(),
            SizedBox(height: 20),

            // Auto/Tele-Op Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text('Auto / Tele-op', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCounter('L4', l4Score, (val) => l4Score += val),
                          _buildCounter('L3', l3Score, (val) => l3Score += val),
                          _buildCounter('L2', l2Score, (val) => l2Score += val),
                          _buildCounter('L1', l1Score, (val) => l1Score += val),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildCounter('Net', netShots, (val) => netShots += val),
                          _buildCounter('Processor', processorShots, (val) => processorShots += val),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Endgame Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text('Endgame', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildToggleButton('Shallow', shallowSelected, () => setState(() => shallowSelected = !shallowSelected)),
                      _buildToggleButton('Deep', deepSelected, () => setState(() => deepSelected = !deepSelected)),
                      _buildToggleButton('Park', parkSelected, () => setState(() => parkSelected = !parkSelected)),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildCheckbox('Defense?', defense, (value) => setState(() => defense = value!)),
                  _buildCheckbox('Robot Broke?', robotBroke, (value) => setState(() => robotBroke = value!)),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Save Button
            ElevatedButton(
                onPressed: () {
                  DataStorage.l1ScoreTeleop = l1Score;
                  DataStorage.l2ScoreTeleop = l2Score;
                  DataStorage.l3ScoreTeleop = l3Score;
                  DataStorage.l4ScoreTeleop = l4Score;
                  DataStorage.netShotsTeleop = netShots;
                  DataStorage.processorShotsTeleop = processorShots;
                  DataStorage.shallowSelected = shallowSelected;
                  DataStorage.deepSelected = deepSelected;
                  DataStorage.parkSelected = parkSelected;
                  DataStorage.defense = defense;
                  DataStorage.robotBroke = robotBroke;
                  showSaveDialog(context);
                },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}