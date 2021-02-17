PrintWriter outputx; //<>//
String resource = "uber.txt";
String filterF = "filter.txt";
void setup()
{
  String[] res = split(join(loadStrings(resource), ""), ".");
  String resStr = join(loadStrings(resource), "");
  outputx = createWriter("output.txt");
  for (int xx= 0; xx < res.length; xx++) { 
    String output = "";
    String[] sentence = split(res[xx], " ");
    for (int x = 1; x <  sentence.length-2; x++) {
      boolean exit = false; 
      String oneA = sentence[x];
      String[] sentenceB = split(res[round(random(res.length-1))], " ");
      for (int y = 1; y < sentenceB.length-2 && exit == false; y++) {
        String oneB = sentenceB[y];
        if (oneA.length() > 4 && oneB.length() > 4 && resStr.indexOf(oneA + " " + oneB) > -1 && resStr.indexOf(oneA) < resStr.indexOf(oneB) && output.indexOf(oneA + " " + oneB) == -1) {
          String[] words = split(output, " ");
          String check = words[words.length-1];
          if (words.length > 2) {
            check = words[words.length-2];
          }
          if (res[xx].indexOf(check) < resStr.indexOf(oneA)) {
            output += sentence[x-1] + " " + oneA + " " + oneB + " " + sentenceB[y+1] + " " ;
            exit = true;
          }
        }
      }
    }
    outputx.print(output);
    outputx.flush();
  }
}
