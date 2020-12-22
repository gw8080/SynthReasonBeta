PrintWriter outputx; //<>//
PrintWriter outputz;
int num = 100;
int sens = 0;
int searchlengthInit = 128;
int distanceParamA = 64;
int distanceParamB = 32;
void setup()
{
  outputz = createWriter("output/output.txt");
  for (int loop = 0; loop < num; loop++) {  
    String spectrum = decide(initTuring("turing.txt"), probability("prob.txt"));
    spectrum = generate(spectrum, loadFilter("filter.txt"), loadResources("text.txt"));
    outputz.println(spectrum);
    outputz.println();
    outputz.flush();
  }
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
String decide(String[] spectrumA, String[] prob) {

  float r7 = 0;
  int rem = 0;
  String[] syntax = new String[1024];
  String[] syntaxT = new String[1024];
  for (int x = 0; x < num; x++) {
    for (int z = 0; z < searchlengthInit; z++) {
      r7 = random(spectrumA.length-1);
      rem = round(r7);
      if (int(prob[rem]) > 0) {
        break;
      }
    }
    int distance = distanceSelect("distance.txt", rem, distanceParamB);
    String[] specx = split(spectrumA[rem], " ");
    if (int(prob[rem]) >= sens && syntax[distance] == null) {
      syntax[distance] = specx[0];
    }
    if (int(prob[rem]) >= sens && syntaxT[distance] == null) {
      syntaxT[distance] = specx[1];
    }
  }
  String spectrumout = "";
  for (int x = 0; x < syntax.length; x++) {
    if (syntax[x] != null) {
      spectrumout += syntax[x] + " ";
    }
  }
  for (int x = 0; x < syntaxT.length; x++) {
    if (syntaxT[x] != null) {
      spectrumout += syntaxT[x] + " ";
    }
  }
  return spectrumout;
}
int distanceSelect(String resource, int pos, int pos2) {
  String[] distanceA = loadResourcesB(resource);
  String[] arr = split(distanceA[pos], ",");
  int exit = 0;
  int selection = 0;
  for (int x = 0; x < distanceParamA && exit == 0; x++) {
    for (int z = 0; z < arr.length - 1 && exit == 0; z++) {
      if (int(arr[z]) == x && x < distanceParamB ) {
        selection = x;
        exit = 1;
      }
    }
  }
  return selection;
}
String generate(String spectrum, String[] loopA, String full) {
  String loop = join(loopA, "\n");
  String[] eny = split(spectrum, " ");// guide
  for (int j = 0; j < eny.length - 2; j++) {
    for (int a = 0; a != loopA.length-1; a++) {
      float r = random(loopA.length-1);
      int x = round(r);
      if (loopA[x] != null ) {
        if (full.indexOf(eny[j] + " " + loopA[x] + " ") > -1 && full.indexOf(" " + loopA[x] + " " + eny[j+1]) > -1 && loop.indexOf("\n" + eny[j] + "\n") == -1 && loop.indexOf("\n" + eny[j+1] + "\n") == -1) {
          spectrum = spectrum.replace(eny[j] + " " + eny[j+1]  + " ", eny[j] + " " + loopA[x] + " " + eny[j+1] + " ");
          break;
        }
      }
    }
  }
  spectrum += ".";
  spectrum = spectrum.replace(" .", ".");
  spectrum = spectrum.replace("^^", " ");
  return spectrum;
}
