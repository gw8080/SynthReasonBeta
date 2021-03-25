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
  String resource = "reason.txt";// knowledgebase
  String rules = "reason.txt";// syntax rules
  String workingMem = "reason.txt";// working memory
  String output = processSentences(split(processRules(loadVocabFiles(30, resource).split(":::::"), rules), "::"), workingMem, loadVocabFiles(30, resource).split(":::::"));
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}
String processSentences(String[] catfull, String workingMem, String[] vocabprep) {
  String output = "";
  for (int catPos2 = 0; catPos2 != catfull.length-1; catPos2++)
  {
    output += returnSentence(catfull, workingMem, vocabprep, catPos2, 200);
  }
  return output;
}
String returnSentence(String[] catfull, String workingMem, String[] vocabprep, int catPos2, int scan) {
  String output = "";
  String[]cat = split(catfull[catPos2], ",");
  String[] res = split(join(loadStrings(workingMem), "").replace(",", ""), ".");
  if (cat.length-1 > 2) {
    for (int catPos = 0; catPos < cat.length-2; catPos++)
    {
      output += returnWords(res, vocabprep, cat, catPos, scan);
    }
  }
  output += ".\n";
  return output;
}
String returnWords(String[] res, String[] vocabprep, String[] cat, int catPos, int scan) {
  String modulate = "";
  boolean exit = false;
  for (int loop = 0; loop < scan && exit == false; loop++ ) {
    int x = round(random(split(vocabprep[int (cat[catPos+1])], "\n").length-1));
    String[] words = split(vocabprep[int (cat[catPos])], "\n");
    for (int loop2 = 0; loop2 < scan && exit == false; loop2++ ) {
      int x2 = round(random(words.length-2));
      for (int lo = 0; lo < scan && exit == false; lo++ ) {
        int z = round(random(res.length-2));
        if (res[z].indexOf(" " + words[x2] + " ") > -1 && res[z].indexOf(" " + split(vocabprep[int (cat[catPos+1])], "\n")[x] + " ") > -1 && res[z].indexOf(" " + words[x2] + " ") < res[z].indexOf(" " + split(vocabprep[int (cat[catPos+1])], "\n")[x] + " ") && words[x2].length() > 1 && split(vocabprep[int (cat[catPos+1])], "\n")[x].length() > 1) {
          int rand = 0;
          for (int f = 0; f < 10; f++) {
            rand = round(random(5));
            if (x2+rand < words.length-1) {
              break;
            }
            rand = 0;
          }
          int rand2 = 0;
          for (int f = 0; f < 10; f++) {
            rand2 = round(random(5));
            if (x+rand2 < split(vocabprep[int (cat[catPos+1])], "\n").length-1) {
              break;
            }
            rand2 = 0;
          }

          modulate = words[x2+rand] + " " + split(vocabprep[int (cat[catPos+1])], "\n")[x+rand2]+ " ";
          catPos++;
          exit = true;
        }
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
