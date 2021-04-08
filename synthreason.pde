PrintWriter outputx;
int paramSize = 5000;
int wordAttempts = 150;
String rules = "reason.txt";// syntax rules
void setup()
{
  String resource = "reason.txt";// knowledgebase
  String output = processSentences(loadVocabFiles(30).split(":::::"), resource);
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}
String processSentences(String[] vocabprep, String resource) {
  String output = "";
  String[] res = split(join(loadStrings("dictionary.txt"), "\n").replace(",", "").toLowerCase(), "\n");
  String[] resB = split(join(loadStrings(resource), "\n").replace(",", "").toLowerCase(), " ");
  String resC = join(resB, " ");
  for (int a = 0; a < wordAttempts; a++) {
    output += divide(meaning(resB[a], res, resC), returnList(vocabprep, resB[a])) + " ";
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
      if (dic.indexOf("\n" + state[rand] + "\n") == -1) {
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
String processRules(String[] vocabprep, String rules) { 
  String txt = "";
  String enxStr = join(loadStrings(rules), "").replace(",", "").replace(";", "");
  String[] enx = split(enxStr, ".");
  for (int z = 0; z < enx.length; z++)
  {
    String[]enwords = split(enx[z], " ");
    for (int x = 0; x < enwords.length; x++)
    {
      for (int y = 0; y < vocabprep.length; y++)
      {
        if (vocabprep[y].indexOf(enwords[x] + "\n") > -1)
        {
          txt += y + ",";// load rules
          break;
        }
      }
    }
  }
  return txt;
}
