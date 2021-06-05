PrintWriter outputx;
String mentalResource = "exp.txt";
String NLP_Resource = "exp.txt";
int retryLimit = 50;
int sentenceCount = 10;
void setup()
{
  String[] simulationData = split(join(loadStrings(mentalResource), ""), ".");
  String[] res = split(join(loadStrings(NLP_Resource), ""), " ");
  String output = "";
  for (int h2 = 0; h2 < sentenceCount; h2++ ) {
    int count = 0;
    int x = round(random(simulationData.length-1));
    int NLPconstructionAttempts = split(simulationData[x], " ").length-1;
    for (int h = 0; h < NLPconstructionAttempts-1; count++) {
      String combo1 = words(split(simulationData[x], " ")[h], res);
      if (output.length() == 0) {
        output = combo1 + " ";
        h++;
      }
      if (output.length() > 0 && combo1.length() > 0 && split(combo1, " ")[0].length() > 3) {
        String process = "";
        String[] test = split(output, " ");
        for (int a = 0; a < test.length-3; a++) {
          process += test[a] + " ";
        }
        output = process + combo1 + " ";
        h++;
      }
      if (count > retryLimit*NLPconstructionAttempts) {
        h++;
        count = 0;
      }
    }
    output += ".\n";
  }
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.close();
  exit();
}
String words(String input, String[] res) {
  String state = "";
  for (int x = 1; x < 10000; x++ ) {
    int rand = round(random(res.length-5))+2;
    if ( res[rand].equals(input) == true) {
      state = res[rand-1] + " " +  res[rand] + " " + res[rand+1];
      break;
    }
  }
  return state;
}
