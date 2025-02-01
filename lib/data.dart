import 'dart:convert';

class DataStorage {
  static String competition = '';
  static int selectedMatch = 1;
  static String teamNumber = '';
  static String selectedAlliance = '';
  static int l1Score = 0;
  static int l2Score = 0;
  static int l3Score = 0;
  static int l4Score = 0;
  static int netShots = 0;
  static int processorShots = 0;
  static bool shallowSelected = false;
  static bool parkSelected = false;
  static bool deepSelected = false;
  static bool defense = false;
  static bool robotBroke = false;
  static String comments = '';

  static Map<String, dynamic> scoutedData = {};

  static void storeData({
    required String competition,
    required int selectedMath,
    required String teamNumber,
    required String selectedAlliance,
    required int l1Score,
    required int l2Score,
    required int l3Score,
    required int l4Score,
    required int netShots,
    required int processorShots,
    required bool shallowSelected,
    required bool parkSelected,
    required bool deepSelected,
    required bool defense,
    required bool robotBroke,
    required String comments
  }) {
    scoutedData = {
      'competition': competition,
      'selectedMatch': selectedMatch,
      'teamNumber': teamNumber,
      'selectedAlliance': selectedAlliance,
      'auto' : {
        'l1Score': l1Score,
        'l2Score': l2Score,
        'l3Score': l3Score,
        'l4Score': l4Score,
        'netShots': netShots,
        'processorShots': processorShots,
      },
      'teleop': {
        'l1Score': l1Score,
        'l2Score': l2Score,
        'l3Score': l3Score,
        'l4Score': l4Score,
        'netShots': netShots,
        'processorShots': processorShots,
      },
      'endgame': {
        'shallowSelected': shallowSelected,
        'parkSelected': parkSelected,
        'deepSelected': deepSelected,
      },
      'l1Score': l1Score,
      'l2Score': l2Score,
      'l3Score': l3Score,
      'l4Score': l4Score,
      'netShots': netShots,
      'processorShots': processorShots,
      'shallowSelected': shallowSelected,
      'parkSelected': parkSelected,
      'deepSelected': deepSelected,
      'defense': defense,
      'robotBroke': robotBroke,
      'comments': comments,
    };
  }

  static String toJson() {
    return jsonEncode(scoutedData);
  }

  static void storeHomeData(int match, String team, String alliance) {
    selectedMatch = match;
    teamNumber = team;
    selectedAlliance = alliance;
  }

  static void storeScoutedData(int l1, int l2, int l3, int l4, int net, int processor, bool shallow, bool park, bool deep, bool def, bool broke) {
    l1Score = l1;
    l2Score = l2;
    l3Score = l3;
    l4Score = l4;
    netShots = net;
    processorShots = processor;
    shallowSelected = shallow;
    parkSelected = park;
    deepSelected = deep;
    defense = def;
    robotBroke = broke;
  }

  static void storeComments(String comments) {
    scoutedData['comments'] = comments;
  }

  static String exportData() {
    return jsonEncode(scoutedData);
  }

  static String get data => 'Match: $selectedMatch, Team: $teamNumber, Alliance: $selectedAlliance';
}
