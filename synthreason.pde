PrintWriter outputx;
int attempts = 100;
int detection = 10;
int scan = 1000;
int flow = 5;
String text = "reason.txt";
void setup()
{
  String[] resource = split(join(loadStrings(text), ""), ".");
  String[] noun = loadStrings("noun.txt");
  String[] verb = loadStrings("verb.txt");
  String[] vocabprep = split(loadVocabFiles(30), ":::::");
  String[] memory = split(join(loadStrings("exp.txt"), ""), ".");
  String output = "";
  for (int h = 0; h < attempts; ) {
    int y = round(random(noun.length-1));
    int z = round(random(verb.length-1));
    String object = noun[y];
    String interaction = verb[z];
    //interaction = "align";
    for (int x = 0; x < flow; x++) {
      String rateOfChange = change(object, interaction, resource);
      if (rateOfChange.equals("0/0") == false && int(split(rateOfChange, "/")[0]) > detection) {
        String test = divide(join(memory, ""), returnList(vocabprep, interaction), interaction);
        String test2 = divide(join(memory, ""), returnList(vocabprep, object), object);
        output += test + " " + test2 + " ";
        interaction = split(test, " ")[split(test, " ").length-1];
        object = split(test2, " ")[split(test2, " ").length-1];
        h++;
      }
    }
  }
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.close();
  exit();
}
String divide(String proc, String dic, String check) {
  String word = "";
  String[] state = split(proc, " ");
  for (int x = 0; x < scan; x++) {
    int rand = round(random(state.length-3))+1;
    if (rand > 1) {
      word = state[rand-1] + " " + state[rand] + " " + state[rand+1];
      if (dic.indexOf("\n" + state[rand] + "\n") > -1 && word.indexOf(check) > -1) {       
        break;
      }
    }
  }
  return word;
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
String change(String object, String interaction, String[] resource) {
  String state = "";
  int objectCount = 0, objectReductionCount = 0;
  for (int j = 0; j < resource.length-1; j++) {
    if (resource[j].indexOf(" " + object + " ") > -1) {
      objectCount++;
    }
  }
  String resourceProc = join(resource, ".");
  for (int j = 0; j < resource.length-1; j++) {
    if (resource[j].indexOf(" " + interaction + " ") > -1) {
      resourceProc.replace(resource[j], "");
    }
  }
  String[] resourceA = split(resourceProc, " ");
  for (int j = 0; j < resourceA.length-1; j++) {
    if (resourceA[j].indexOf(" " + object + " ") > -1) {
      objectReductionCount++;
    }
  }
  state = objectCount + "/" + objectReductionCount;
  return state;
}
