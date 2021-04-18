PrintWriter outputx;
int paramSize = 10000;
int contextualAttempts = 100;
void setup()
{
  outputx = createWriter("output.txt");
  String seed = "exp.txt";// seed knowledgebase
  String memory = "merge.txt";// larger knowledgebase
  String[] dic = loadStrings("dictionary.txt");
  for (int i = 0; i < 10; i++) {
    String output = processSentences(dic, loadVocabFiles(30).split(":::::"), split(join(loadStrings(seed), "\n").replace(",", "").toLowerCase(), "\n"), split(join(loadStrings(memory), "\n").replace(",", "").replace("\n", " ").toLowerCase(), "."));
    outputx.println(output);
    outputx.println();
  }
  outputx.close();
  exit();
}
String processSentences(String[] dic, String[] vocabprep, String[] res, String[] res2) {
  String output = "";


  for (int b = 0; b < contextualAttempts; ) {
    int y = round(random(res.length-1));
    String test = divide(dic, res[y], returnList(vocabprep, word(split(output, " ")[split(output, " ").length-1], dic, split(output, " ")[split(output, " ").length-1])), res2, split(output, " ")[split(output, " ").length-1]); 
    if (output.indexOf(test) == -1) {
      output += test + " ";
      b++;
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
String divide(String[] dictionary, String proc, String dic, String[] mem, String previous) {
  String word = "";
  String[] state = split(proc, " ");
  for (int x = 0; x < paramSize; x++) {
    int rand = round(random(state.length-3))+1;
    int y = round(random(mem.length-1));
    if (rand > 1) {
      if (dic.indexOf("\n" + state[rand] + "\n") == -1 && mem[y].indexOf(previous + " " + state[rand-1]) == -1 && previous.indexOf( word(proc, dictionary, state[rand+1])) > -1) {
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
