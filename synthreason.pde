PrintWriter outputx; //<>//
String resource = "exp.txt";
void setup()
{
  String[] res = split(join(loadStrings(resource), ""), ".");
  String resStr = join(loadStrings(resource), "");
  outputx = createWriter("output.txt");
  while (true) { 
    String output = "";
    String[] sentence = split(res[round(random(res.length-1))], " ");
    for (int x = 1; x <  sentence.length-2; x++) {
      boolean exit = false; 
      String oneA = sentence[x];
      String[] sentenceB = split(res[round(random(res.length-1))], " ");
      for (int y = 1; y < sentenceB.length-2 && exit == false; y++) {
        String oneB = sentenceB[y];
        if (oneA.length() > 4 && oneB.length() > 4 && resStr.indexOf(oneA + " " + oneB) > -1 && resStr.indexOf(oneA) < resStr.indexOf(oneB)) {
          String[] words = split(output, " ");
          String check = words[words.length-1];
          if (words.length > 2) {
            check = words[words.length-2];
          }
          if (resStr.indexOf(check) < resStr.indexOf(check + " " + sentence[x-1] + " " + oneA )) {
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
