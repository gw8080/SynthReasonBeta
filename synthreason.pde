PrintWriter outputx; //<>//
String resource = "exp.txt";
String filterF = "filter.txt";
int scanLength = 100;
void setup()
{
  String[] res = split(join(loadStrings(resource), ""), ".");
  String resStr = join(loadStrings(resource), "");
  String[] filterA = loadStrings(filterF);
  outputx = createWriter("output.txt");
  while (true) { 
    String output = "";
    String[] sentence = split(res[round(random(res.length-1))], " ");
    for (int x = 0; x <  sentence.length; x++) {
      boolean exit = false; 
      String oneA = sentence[x];
      String[] sentenceB = split(res[round(random(res.length-1))], " ");
      for (int y = 0; y < sentenceB.length && exit == false; y++) {
        String oneB = sentenceB[y];
        if (oneA.length() > 4 && oneB.length() > 4 && resStr.indexOf(oneA + " " + oneB) > -1 && resStr.indexOf(oneA) < resStr.indexOf(oneB) && output.indexOf(oneA + " " + oneB) == -1) {
          String[] words = split(output, " ");
          String check = words[words.length-1];
          if (words.length > 2) {
            check = words[words.length-2];
          }
          if (resStr.indexOf(check) < resStr.indexOf(oneA)) {
            output += oneA + " " + oneB + " ";
            exit = true;
          }
        }
      }
    }
    String[] words = split(output, " ");
    boolean exit = false; 
    for (int a = 0; a < words.length-1 && exit == false; a++) {
      for (int z = 0; z < scanLength && exit == false; z++) {
        int rand = round(random(filterA.length-1));
        if (resStr.indexOf(words[a] + " " + filterA[rand] + " " + words[a+1]) > -1) {
          output = output.replace(words[a] + " " + words[a+1], words[a] + " " + filterA[rand]+ " " + words[a+1]);
          exit = true;
        }
      }
    }
    outputx.print(output);
    outputx.flush();
  }
}
