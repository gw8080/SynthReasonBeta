PrintWriter outputx, rules;
int paramSize = 5000;
int wordAttempts = 150;
void setup()
{
  outputx = createWriter("output.txt");
  String resource = "reason.txt";// knowledgebase
  String workingMem = "reason.txt";// knowledgebase
  for (int x = 0; x < 15; x++) {
    String output = processSentences(loadVocabFiles(30).split(":::::"), split(join(loadStrings(resource), "\n").replace(",", "").replace("\n", " ").toLowerCase(), "."), split(join(loadStrings(workingMem), "").replace(",", "").replace("\n", " ").toLowerCase(), " "));
    output = output.replace("null", "");
    outputx.println(output);
    outputx.println();
  }
  outputx.flush();
  outputx.close();
  exit();
}
String processSentences(String[] vocabprep, String[] res, String[] workingMem) {
  String[] output = new String[1000000];
  for (int a = 0; a < wordAttempts; a++) {
    int x = round(random(split(join(output, ""), " ").length-1));
    int y = round(random(res.length-2));
    for (int b = 0; b < round(random(5)); b++) {
      String test = divide(res[y], returnList(vocabprep, split(join(output, ""), " ")[split(join(output, ""), " ").length-1])) + " ";
      output[findWord(split(test, " ")[round(random(split(test, " ").length-1))], workingMem)] = test;
    }
  }
  return join(output, "");
}
int findWord(String word, String[] res) {
  int state = 0;
  for (int x = 0; x < res.length-1; x++) {
    if (word.equals(res[x]) == true) {
      state = x;
      break;
    }
  }
  return state;
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
      if (dic.indexOf("\n" + state[rand] + "\n") == -1) {
        word = state[rand-1] + " " + state[rand] + " " + state[rand+1];
        break;
      }
    }
  }
  return word;
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
