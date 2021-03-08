PrintWriter outputx;
PrintWriter debug;
int scanLength = 150;
int lines = 150;
String resource = "reason.txt";
void setup()
{
  String[] KB = split(join(loadStrings(resource), ""), " ");
  String[] contextA = loadStrings("context.txt");
  String run = contextA[round(random(contextA.length-1))] + " ";
  outputx = createWriter("output.txt");
  for (int x = 0; x < lines; x++) {
    for (int n = 1; n < scanLength; n++) {
      String outputC = select(KB, split(run, " ")[split(run, " ").length-2], n, findLocation(KB, select(KB, split(run, " ")[round(random(split(run, " ").length-1))], 0, 0)));
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
