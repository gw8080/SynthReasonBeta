PrintWriter outputx;
String resource = "exp.txt";// knowledgebase
void setup()
{
  String test = join(loadStrings(resource), "");
  String output = "", check = "";
  String[] tokenText = split(join(loadStrings(resource), ""), " ");
  for (int a = 0; a < tokenText.length; a++) {
    int x = round(random(test.length()-1));
    if (test.indexOf(tokenText[a] + " ", x) > -1) {
      String test2 = test.substring(test.indexOf(tokenText[a] + " ", x), test.indexOf(".", test.indexOf(tokenText[a] + " ", x)));
      if (check.indexOf(split(test2, " ")[0]) == -1 && split(test2, " ").length > 1) {
        output += split(test2, " ")[0] + " ";
        check += split(test2, " ")[1] + " ";
      }
    }
  }
  outputx = createWriter("output.txt");
  outputx.print(output);
  outputx.flush();
  exit();
}
