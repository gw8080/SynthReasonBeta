PrintWriter outputx;
String resource = "uber.txt";
void setup()
{
  String voc = "";
  String[] KB = loadStrings(resource);
  String[] vocab = loadStrings("words.txt");
  String str2 = join(KB, "");
  for (int i = 0; i != vocab.length; i++)
  {
    if (str2.indexOf(" " + vocab[i] + " ") > -1) {
      voc += vocab[i] + "\n";
    }
  }
  String[] list = new String[10240000];
  String[] listName = new String[10240000];
  int num = 0;
  String[] knowledge = loadResources(resource);
  String[] words = split(voc, "\n");
  for (int x = 1; x < words.length-1; x++) {
    list[num] = "";
    for (int y = 1; y < knowledge.length-20; y++) {
      if (words[x].equals(knowledge[y]) == true) {
        list[num] += knowledge[y+1] + "\n";
        listName[num] = words[x];
      }
    }
    num++;
  }
  for (int x = 0; x < list.length; x++) {
    if (list[x] != null) {
      outputx = createWriter("node/" + x + ".txt");
      outputx.print(list[x]);
      outputx.flush();
      outputx.close();
      outputx = createWriter("node/" + listName[x] + ".txt");
      outputx.print(list[x]);
      outputx.flush();
      outputx.close();
    }
  }
  exit();
}
String[] loadResources(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] eliminate2 = {"[", "]", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
  for (int k = 0; k < eliminate2.length; k++) {
    str2 = str2.replace(eliminate2[k], "");
  }
  str2 = str2.toLowerCase();
  while (str2.indexOf(".") > -1) {
    str2 = str2.replace(".", " ");
  }
  String[] str3 = split(str2, " ");
  return str3;
}
String loadResourcesB(String resource)
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
  return str2;
}

String loadFilter(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");

  return str2;
}
