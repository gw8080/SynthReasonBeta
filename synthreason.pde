PrintWriter outputx;
int paramSize = 5000;
int wordAttempts = 150;
void setup()
{
  outputx = createWriter("output.txt");
  String resource = "uber.txt";// knowledgebase
  for (int x = 0; x < 15; x++) {
    String output = processSentences(loadVocabFiles(30).split(":::::"), resource);
    outputx.println(output);
    outputx.println();
    outputx.println();
    outputx.println();
  }
  outputx.flush();
  outputx.close();
  exit();
}
String processSentences(String[] vocabprep, String resource) {
  String output = "";
  String[] res = split(join(loadStrings("dictionary.txt"), "\n").replace(",", "").toLowerCase(), "\n");
  String[] resB = split(join(loadStrings(resource), "\n").replace(",", "").toLowerCase(), ".");
  String resC = join(resB, " ");
  for (int a = 0; a < wordAttempts; a++) {
    int x = round(random(split(output, " ").length-1));
    int y = round(random(resB.length-1));
    output += divide(resB[y], returnList(vocabprep, split(output, " ")[x])) + " ";
    //meaning(split(output, " ")[x], res, resC)
  }
  return output;
}
String returnList(String[] vocabprep, String word) {
  String list = "";
  for (int x = 0; x < vocabprep.length-1; x++) {
    if (vocabprep[x].indexOf("\n" + word + "\n") > -1) {
      list = vocabprep[x];
      break;
    }
  }
  return list;
}
String divide(String proc, String dic) {
  String word = "";
  String[] state = split(proc, " ");
  for (int x = 0; x < paramSize; x++) {
    int rand = round(random(state.length-3))+1;
    if (rand > 1) {
      if (dic.indexOf("\n" + state[rand-1] + "\n") == -1 &&dic.indexOf("\n" + state[rand] + "\n") == -1 && dic.indexOf("\n" + state[rand+1] + "\n") == -1) {
        word = state[rand-1] + " " + state[rand] + " " + state[rand+1];
        break;
      }
    }
  }
  return word;
}
String meaning(String word, String[] res, String check) {
  String ret = "";

  for (int x = 0; x < paramSize; x++) {
    int y = round(random(res.length-1));
    String[] array = split(res[y], "|");
    if (array.length-1 == 1 && check.indexOf(array[0]) > -1) {
      if (array[1].replace(",", "").indexOf(" " + word + " ") > -1) {
        ret = split(res[y], "|")[1];
        break;
      }
    }
  }
  return ret;
}
String loadVocabFiles(int MAX) {
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < MAX; count++)
  {
    vocabproc = loadStrings(count + ".txt");
    if (vocabproc != null)
    {
      String voc = join(vocabproc, '\n');
      if (voc.length() > 0)
      {
        vocabsyn += voc + ":::::";// load vocabulary
      }
      if (voc.length() == 0)
      {
        break;
      }
    }
  }
  return vocabsyn;
}
