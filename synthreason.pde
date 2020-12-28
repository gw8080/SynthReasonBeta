PrintWriter outputx; //<>// //<>// //<>// //<>//
PrintWriter outputy;
PrintWriter outputz;
int block = 256;
int num = 10;
int sens = 64;
int searchlength = 64;
int searchlength2 = 64;
int searchlengthInit = 64;
int selectionSize = 64;
int distanceParamA = 64;
int distanceParamB = 8;
void setup()
{
  outputz = createWriter("output/output.txt");
  String spectrum = "";
  for (int loop = 0; loop < num; loop++) {  
    spectrum += decide(initTuring("turing.txt"), probability("prob.txt"), loadFilter("filter.txt"));
  }
  spectrum = generate(spectrum, loadFilter("filter.txt"), loadResources("text.txt"));
  outputz.println(spectrum);
  outputz.println();
  outputz.flush();
  outputz.close();
  exit();
}
String[] loadFilter(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
  String[] str3 = split(str2, "\n");
  return str3;
}
String loadFilterstr(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
  return str2;
}
String loadResources(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  return str2;
}
String[] loadResourcesA(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, ".");
  return str3;
}
String[] loadResourcesB(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, ":");
  return str3;
}
String[] initTuring(String file) {
  String[] KB = loadStrings(file);
  String spectrumx = join(KB, "");
  String[] spectrumA = split(spectrumx, ",");
  return spectrumA;
}
String[] probability(String file) {
  String[] KB = loadStrings(file);
  String list = join(KB, "");
  String[] prob = split(list, ",");
  return prob;
}
String collocate(String[] spectrumA, String[] spec) {
  String collocates = "";
  String[] spec2 = new String[0];
  for (int count = 0; count < spectrumA.length-2; count++) {
    float r = random(spectrumA.length-2);
    int xx = round(r);
    spec2 = split(spectrumA[xx], " ");
    if (spec[0].equals(spec2[0]) == true) {
      collocates += spec2[0] + " " + spec2[1] + ",";
    }
  }
  return collocates;
}
String[] collocate_spec2(String[] spectrumA, String[] spec) {
  String collocates = "";
  String[] spec2 = new String[0];
  for (int count = 0; count < spectrumA.length-2; count++) {
    float r = random(spectrumA.length-2);
    int xx = round(r);
    spec2 = split(spectrumA[xx], " ");
    if (spec[0].equals(spec2[0]) == true) {
      collocates += spec2[0] + " " + spec2[1] + ",";
    }
  }
  return spec2;
}
String[] task_AC(String[] spectrumA, String[] prob) {
  String[] spec = new String[0];
  for (int count = 0; count < searchlengthInit; count++) {
    float r = random(spectrumA.length-1);
    int xx = round(r);
    spec = split(spectrumA[xx], " ");
    if (int(prob[xx]) > 20 ) {
      break;
    }
  }
  return spec;
}
String[] sentencesCombined(String[] collocatesA, String[] spectrumA, String[] spec2, String[] kernelsentenceA ) {
  String sentence1 = "", sentence2 = "";
  for (int count = 0; count < collocatesA.length-1; count++) {
    float r = random(collocatesA.length-1);
    int xx = round(r);
    spec2 = split(spectrumA[xx], " ");
    String[] spec3 = split(collocatesA[count], " ");
    if (spec3[0].equals(kernelsentenceA[0]) == true) {
      sentence1 += spec2[1] + ",";
    }
    if (spec3[0].equals(kernelsentenceA[1]) == true) {
      sentence2 += spec2[1] + ",";
    }
  }
  String[] sentenceCombined = split(sentence1+"::"+sentence2, "::");
  return sentenceCombined;
}
String decide(String[] spectrumA, String[] prob, String[] check2) {
  String spectrumout = "";
  boolean exit = false, exit2 = false, exit3 = false, exit4 = false, exit5 = false;
  for (String[] spec = task_AC(spectrumA, prob); exit == false; ) {
    String[] spec2 = new String[0];
    for (spec2 = collocate_spec2(spectrumA, spec); exit2 == false; ) {
      // recogniser
      exit2 = true;
    }
    String collocates = "";
    for (collocates = collocate(spectrumA, spec); exit3 == false; ) {
      // recogniser
      exit3 = true;
    }
    String[] kernelsentenceA = new String[0];
    String kernelsentence = ""; 
    for (kernelsentence = join(task_AC(spectrumA, prob), " "); exit4 == false; ) {
      kernelsentenceA = split(kernelsentence, " ");
      // recogniser
      exit4 = true;
    }
    String[] collocatesA = split(collocates, ",");
    for (String[] sentences = sentencesCombined(collocatesA, spectrumA, spec2, kernelsentenceA); exit5 == false; ) {
      //output
      String[] sentence1A = split(sentences[0], ",");
      String[] sentence2A = split(sentences[1], ",");
      float r = random(sentence1A.length-1);
      int random = round(r);
      spectrumout = kernelsentence + " " + sentence1A[random];
      exit5 = true;
    }
    exit = true;
  }


  return spectrumout;
}
String generate(String spectrum, String[] loopA, String full) {
  String loop = join(loopA, "\n");
  String[] eny = split(spectrum, " ");// guide
  for (int j = 0; j < eny.length - 2; j++) {
    for (int a = 0; a != loopA.length-1; a++) {
      float r = random(loopA.length-1);
      int x = round(r);
      if (loopA[x] != null ) {
        if (full.indexOf(eny[j] + " " + loopA[x] + " ") > -1 && full.indexOf(" " + loopA[x] + " " + eny[j+1]) > -1) {
          spectrum = spectrum.replace(eny[j] + " " + eny[j+1] + " ", eny[j] + " " + loopA[x] + "^^" + eny[j+1] + " ");
          break;
        }
      }
    }
  }
  spectrum = spectrum.replace("^^", " ");
  return spectrum;
}
