PrintWriter outputx;
int paramSize = 10000;
int contextualAttempts = 50;
void setup()
{
  String resource = "exp.txt";// knowledgebase
  String[] dic = loadStrings("dictionary.txt");
  String output = processSentences(dic, loadVocabFiles(30).split(":::::"), split(join(loadStrings(resource), "\n").replace(",", "").replace("\n", " ").toLowerCase(), "."));
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.close();
  exit();
}
String processSentences(String[] dic, String[] vocabprep, String[] res) {
  String output = "";
  int y = round(random(res.length-2));
  String test = divide(res[y], returnList(vocabprep, word(split(output, " ")[split(output, " ").length-1], dic, split(output, " ")[split(output, " ").length-1])));
  output += test + " ";
  for (int b = 0; b < contextualAttempts; ) {
    y = round(random(res.length-2));
    test = divide(res[y], returnList(vocabprep, word(split(output, " ")[split(output, " ").length-1], dic, split(output, " ")[split(output, " ").length-1])));
    if (split(test, " ").length > 2) {
      b++;
      String check = split(test, " ")[split(test, " ").length-1]; 
      if (check.length()-1 < 3) {
        test = divide(res[y], returnList(vocabprep, word(split(output, " ")[split(output, " ").length-2], dic, split(output, " ")[split(output, " ").length-2])));
      }
      output += test + " ";
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
      if (dic.indexOf("\n" + state[rand] + "\n") > -1) {
        word = state[rand-1] + " " + state[rand] + " " + state[rand+1];
        break;
      }
    }
  }
  return word;
}
String word(String meaning, String[] res, String check) {
  String ret = "";
  meaning = meaning.replace(",", "");
  for (int x = 0; x < 1000; x++) {
    int y = round(random(res.length-1));
    String[] array = split(res[y], "|");
    if (array.length-1 == 1) {
      if (array[1].indexOf(" " + meaning + " ") > -1 && array[1].indexOf(" " + check + " ") > -1) {
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
