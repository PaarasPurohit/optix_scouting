import 'dart:convert';

class DataStorage {
  static String competition = '';
  static int selectedMatch = 1;
  static String teamNumber = '';
  static String selectedAlliance = '';

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
    String comments = '',
  }) {
    scoutedData = {
      'competition': competition,
      'selectedMatch': selectedMatch,
      'teamNumber': teamNumber,
      'selectedAlliance': selectedAlliance,
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

  static String get data => 'Match: $selectedMatch, Team: $teamNumber, Alliance: $selectedAlliance';
}
