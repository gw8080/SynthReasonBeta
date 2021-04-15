PrintWriter outputx;
int paramSize = 1000;
int contextualAttempts = 100;
void setup()
{
  String resource = "reason.txt";// knowledgebase
  String workingMem = "reason.txt";// knowledgebase
  String[] dic = loadStrings("dictionary.txt");
  String output = processSentences(dic, loadVocabFiles(30).split(":::::"), split(join(loadStrings(resource), "\n").replace(",", "").replace("\n", " ").toLowerCase(), "."), split(join(loadStrings(workingMem), "").replace(",", "").replace("\n", " ").toLowerCase(), " "));
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.close();
  exit();
}
String processSentences(String[] dic, String[] vocabprep, String[] res, String[] workingMem) {
  String output = "";
  for (int b = 0; b < contextualAttempts; ) {
    int x = round(random(split(output, " ").length-1));
    int y = round(random(res.length-2));
    String test = divide(res[y], returnList(vocabprep, split(output, " ")[x]));
    String testprep = word(test, dic, split(output, " ")[round(random(split(output, " ").length-1))], split(output, " ")[round(random(split(output, " ").length-1))], split(output, " ")[round(random(split(output, " ").length-1))]);
    if (test.length() > 2 && testprep.length() > 2) {
      if (test.indexOf(testprep) == -1 && test.indexOf(split(output, " ")[split(output, " ").length-1]) > -1) {
        output +=  testprep + " " + test + " ";
        b++;
      }
    }
  }
  return output;
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
String word(String meaning, String[] res, String check, String check2, String check3) {
  String ret = "";
  meaning = meaning.replace(",", "");
  for (int x = 0; x < 1000; x++) {
    int y = round(random(res.length-1));
    String[] array = split(res[y], "|");
    if (array.length-1 == 1) {
      if (array[1].indexOf(" " + meaning + " ") > -1 && array[1].indexOf(" " + check2 + " ") > -1 && array[1].indexOf(" " + check3 + " ") > -1 && array[1].indexOf(" " + check + " ") > -1) {
        ret = split(res[y], "|")[0];
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
