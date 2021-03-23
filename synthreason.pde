/* 
 Copyright (C) 2021 George Wagenknecht SynthReason, This program is free
 software; you can redistribute it and/or modify it under the terms of the
 GNU General Public License as published by the Free Software Foundation;
 either version 2 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT 
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 more details. You should have received a copy of the GNU General Public
 License along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA */

PrintWriter outputx, debug;
void setup()
{
  outputx = createWriter("output.txt");
  String resource = "cyb.txt";// knowledgebase
  String rules = "reason.txt";// syntax rules
  String workingMem = "exp.txt";// working memory
  String output = processSentences(split(processRules(loadVocabFiles(30, resource).split(":::::"), rules), "::"), workingMem, loadVocabFiles(30, resource).split(":::::"));
  outputx.close();
  exit();
}
int StringMatch(String one, String two, String splitToken, int tries) {

  String[] Background = split(one, splitToken);
  String[] match = split(two, splitToken);
  int state = 0;
  for (int a = 0; a < tries; a++) {
    if (func(Background, match, splitToken, 3, round(random(Background.length-1))) == true) {
      state++;
    }
  }
  return state;
}

boolean func(String[] Background, String[] match, String splitToken, int size, int pos) {
  boolean state = false;
  String check ="";
  if (pos+size <= Background.length-1 && match.length-1 >= size+pos) {
    for (int a = pos; a < size; a++) {
      check += match[a] + splitToken;
    }
  }
  if (join(Background, splitToken).indexOf(check, pos) > -1 && check.length() > 0) {
    state = true;
  }
  return state;
}
String processSentences(String[] catfull, String workingMem, String[] vocabprep) {
  String output = "";
  int minSentenceSize = 5;
  int maxSentenceSize = 10;
  String[] res = split(join(loadStrings("dictionary.txt"), "\n").replace(",", ""), "\n");
  for (int catPos2 = 0; catPos2 != catfull.length-1; catPos2++)
  {
    String[]cat = split(catfull[catPos2], ",");
    String out = returnSentence(catfull, workingMem, vocabprep, catPos2, 200, minSentenceSize, maxSentenceSize);
    for (int catPos = 0; catPos <= cat.length-1; catPos++) {
      String check = vocabprep[int (cat[catPos])];
      output = "";
      for (int x =0; x < res.length-1; x++) {
        if (StringMatch(res[x], out, " ", 100) > 20 ) {
          if (check.indexOf("\n" + split(res[x], "|")[0] + "\n") > -1) {
            output = split(res[x], "|")[0] + " ";
            outputx.print(output);
            outputx.flush();
            break;
          }
        }
      }
      if (output.equals("") == true) {
        outputx.print(split(vocabprep[int (cat[catPos])], "\n")[round(random(split(vocabprep[int (cat[catPos])], "\n").length-1))] + " ");
        outputx.flush();
      }
    }
    outputx.print(".\n");
  }
  return output;
}
String returnSentence(String[] catfull, String workingMem, String[] vocabprep, int catPos2, int scan, int minSentenceSize, int maxSentenceSize) {
  String output = "";
  String[]cat = split(catfull[catPos2], ",");
  String[] res = split(join(loadStrings(workingMem), "").replace(",", ""), ".");
  if (cat.length-1 >= minSentenceSize && cat.length-1 <= maxSentenceSize) {
    int x = 0;
    for (int catPos = 0; catPos < cat.length-1; catPos++)
    {
      String[] resPos = split(manageMem(res, round(random(res.length-1)), 5), ",");
      if (x < resPos.length-1) {
        x++;
      }
      if (x >= resPos.length-1) {
        x = 0;
      }
      output += returnWords(res, int(resPos[x]), vocabprep, cat, catPos, scan);
    }
  }
  output += ".\n";
  return output;
}
String manageMem(String[] res, int location, int size) {
  String str = "";
  for (int x = location; x <= location+size; x++) {
    if (location+size <= res.length-1) {
      str += str(x)+",";
    }
  }
  return str;
}
String returnWords(String[] res, int resPos, String[] vocabprep, String[] cat, int catPos, int scan) {
  String modulate = "";
  boolean exit = false;
  for (int loop = 0; loop < scan && exit == false; loop++ ) {
    int x = round(random(split(vocabprep[int (cat[catPos+1])], "\n").length-1));
    String[] words = split(vocabprep[int (cat[catPos])], "\n");
    for (int loop2 = 0; loop2 < scan && exit == false; loop2++ ) {
      int x2 = round(random(words.length-1));
      if (res[resPos].indexOf(" " + words[x2] + " ") > -1 && res[resPos].indexOf(" " + split(vocabprep[int (cat[catPos+1])], "\n")[x] + " ") > -1 && res[resPos].indexOf(" " + words[x2] + " ") < res[resPos].indexOf(" " + split(vocabprep[int (cat[catPos+1])], "\n")[x] + " ") && words[x2].length() > 1 && split(vocabprep[int (cat[catPos+1])], "\n")[x].length() > 1) {
        modulate = words[x2] + " " + split(vocabprep[int (cat[catPos+1])], "\n")[x]+ " ";
        catPos++;
        exit = true;
      }
    }
  }
  return modulate;
}
String loadVocabFiles(int MAX, String resource) {
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < MAX; count++)
  {
    vocabproc = loadStrings(count + ".txt");
    if (vocabproc != null)
    {
      String vocabStr = "";
      String[] load = split(join(loadStrings(resource), "").toLowerCase(), " ");
      for (int a = 0; a < load.length-1; a++) {
        for (int b = 0; b < vocabproc.length-1; b++) {
          if (load[a].equals(vocabproc[b]) == true && vocabStr.indexOf(vocabproc[b]) == -1) {
            vocabStr += "\n"+ vocabproc[b];
            break;
          }
        }
      }
      String[] vocabproc2 = split(vocabStr, "\n");
      String voc = join(vocabproc2, '\n');
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
String processRules(String[] vocabprep, String rules) { 
  String txt = "";
  String enxStr = join(loadStrings(rules), "").replace(",", "").replace(";", "");
  String[] enx = split(enxStr, ".");
  for (int z = 0; z < enx.length; z++)
  {
    String[]enwords = split(enx[z], " ");
    for (int x = 0; x < enwords.length; x++)
    {
      for (int y = 0; y < vocabprep.length; y++)
      {
        if (vocabprep[y].indexOf(enwords[x] + "\n") > -1)
        {
          txt += y + ",";// load rules
          break;
        }
      }
    }
    txt += "::";
  }
  return txt;
}
