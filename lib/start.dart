import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:optix_scouting/match.dart';
import 'package:optix_scouting/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedMatch = 1;
  String _teamNumber = '';
  String _selectedAlliance = 'Red';
  String _teamName = '';
  String? selectedEvent;

  Map<String, dynamic> events = {};
  List<String> eventNames = [];

  int _currentPage = 0;
  Timer? _timer;

  var teamData;

  final PageController _pageController = PageController();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTeamData();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  Future<void> _loadTeamData() async { 
    final String jsonString = await rootBundle.loadString('assets/databases/teams.json'); 
    var data = jsonDecode(jsonString); 
    setState(() { 
      teamData = data; 
    }); 
    //print(jsonData); 
  }

  Future<void> loadEvents() async {
    String jsonString = await rootBundle.loadString('assets/databases/events.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    
    setState(() {
      events = jsonData;
      eventNames = jsonData.values.map<String>((event) => event["name"]).toList();
    });
  }

  void _updateTeamName(String teamNumber) {
    setState(() {
      _teamName = teamData[teamNumber] ?? 'Unknown Team';
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scouting'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  Image.asset('assets/images/image_1.jpg'),
                  Image.asset('assets/images/image_2.jpg'),
                  Image.asset('assets/images/image_3.jpg'),
                  Image.asset('assets/images/image_4.jpg'),
                ],
              ),
            ),
            FlutterDropdownSearch(
              textController: _controller,
              items: eventNames,
              dropdownHeight: 300,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter Match'),
              initialValue: _selectedMatch.toString(), // Convert int to String
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (newValue) {
                setState(() {
                  _selectedMatch = int.tryParse(newValue) ?? 1;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Team Number'),
              onChanged: (value) {
                _teamNumber = value;
                _updateTeamName(value);
              },
            ),
            SizedBox(height: 8.0), // Add some spacing
            Text(
              _teamName.isNotEmpty ? 'Team: $_teamName' : '',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            DropdownButtonFormField<String>(
              value: _selectedAlliance,
              decoration: InputDecoration(labelText: 'Select Alliance'),
              items: ['Red', 'Blue'].map((alliance) {
                return DropdownMenuItem(
                  value: alliance,
                  child: Text(alliance),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedAlliance = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                  DataStorage.teamNumber = _teamNumber;
                  DataStorage.teamName = _teamName;
                  DataStorage.selectedAlliance = _selectedAlliance;
                  DataStorage.selectedMatch = _selectedMatch;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchPage()),
                );
              },
              child: Text('Start Scout'),
            ),
          ],
        ),
      ),
    );
  }
}
