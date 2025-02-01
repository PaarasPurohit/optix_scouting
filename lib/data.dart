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
      'selectedMatch': selectedMatch,
      'teamNumber': teamNumber,
      'teamName': teamName,
      'selectedAlliance': selectedAlliance,
      'auto': {
        'l1Score': l1ScoreAuto,
        'l2Score': l2ScoreAuto,
        'l3Score': l3ScoreAuto,
        'l4Score': l4ScoreAuto,
        'netShots': netShotsAuto,
        'processorShots': processorShotsAuto,
      },
      'teleop': {
        'l1Score': l1ScoreTeleop,
        'l2Score': l2ScoreTeleop,
        'l3Score': l3ScoreTeleop,
        'l4Score': l4ScoreTeleop,
        'netShots': netShotsTeleop,
        'processorShots': processorShotsTeleop,
      },
      'shallowSelected': shallowSelected,
      'parkSelected': parkSelected,
      'deepSelected': deepSelected,
      'defense': defense,
      'robotBroke': robotBroke,
      'comments': comments,
    };
  }
}