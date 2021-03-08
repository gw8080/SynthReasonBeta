PrintWriter outputx;
PrintWriter debug;
int scanLength = 150;
int lines = 150;
String resource = "exp.txt";
void setup()
{
  String[] KB = loadResource(resource);
  String[] contextA = loadStrings("context.txt");
  String run = contextA[round(random(contextA.length-1))] + " ";
  outputx = createWriter("output.txt");
  for (int x = 0; x < lines; x++) {
    for (int n = 1; n < scanLength; n++) {
      String outputC = select(KB, split(run, " ")[split(run, " ").length-2], n, findLocation(KB, select(KB, split(run, " ")[round(random(split(run, " ").length-2))], 0, 0)));
      if (outputC.length() > 0) {
        run += outputC + " ";
      }
    }
    if (run.length() > 20) {
      outputx.println(run);
      outputx.flush();
    }
    run = contextA[round(random(contextA.length-1))] + " ";
  }
  outputx.close();
  exit();
}

String select(String[] KB, String search, int rel, int location) {
  String output = "";
  for (int a = location; a < KB.length-scanLength; a++) {
    if (KB[a].equals(search) == true) {
      output = KB[a+rel];
    }
  }
  return output;
}
int findLocation(String[] KB, String search) {
  int output = 0;
  for (int a = 0; a < KB.length-scanLength; a++) {
    if (KB[a].equals(search) == true) {
      output = a;
    }
  }
  return output;
}
String[] loadResource(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] eliminate2 = {"[", "]", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
  for (int k = 0; k < eliminate2.length; k++) {
    str2 = str2.replace(eliminate2[k], "");
  }
  while (str2.indexOf(".") > -1) {
    str2 = str2.replace(".", " ");
  }
  str2 = str2.toLowerCase();
  String[] str3 = split(str2, " ");
  return str3;
}
