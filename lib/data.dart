class DataStorage {
  static int selectedMatch = 1;
  static String teamNumber = '';
  static String teamName = '';
  static String selectedAlliance = 'Red';

  static int l1ScoreAuto = 0;
  static int l2ScoreAuto = 0;
  static int l3ScoreAuto = 0;
  static int l4ScoreAuto = 0;
  static int netShotsAuto = 0;
  static int processorShotsAuto = 0;

  static int l1ScoreTeleop = 0;
  static int l2ScoreTeleop = 0;
  static int l3ScoreTeleop = 0;
  static int l4ScoreTeleop = 0;
  static int netShotsTeleop = 0;
  static int processorShotsTeleop = 0;

  static bool shallowSelected = false;
  static bool parkSelected = false;
  static bool deepSelected = false;
  
  static bool defense = false;
  static bool robotBroke = false;

  static String comments = '';

  static Map<String, dynamic> toJson() {
    return {
      'm': selectedMatch,
      'tnu': teamNumber,
      'tna': teamName,
      'ta': selectedAlliance == 'Red' ? 'R' : 'B', // Ensures only 'R' or 'B' is stored
      'a': [l1ScoreAuto, l2ScoreAuto, l3ScoreAuto, l4ScoreAuto, netShotsAuto, processorShotsAuto],
      't': [l1ScoreTeleop, l2ScoreTeleop, l3ScoreTeleop, l4ScoreTeleop, netShotsTeleop, processorShotsTeleop],
      'p': [shallowSelected ? 1 : 0, parkSelected ? 1 : 0, deepSelected ? 1 : 0],
      'd': [defense ? 1 : 0, robotBroke ? 1 : 0],
      'c': comments.isNotEmpty ? comments : '',
    };
  }
}
