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
  String workingMem = "exp.txt";// working memory
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
    String[]cat = split(catfull[catPos2], ",");
    if (cat.length-1 > 2) {
      for (int catPos = 0; catPos < cat.length-2; catPos++)
      {
        output += split(vocabprep[int(cat[catPos])], "\n")[round(random(split(vocabprep[int(cat[catPos])], "\n").length-1))] + " ";
      }
    }
    output+=".\n";
  }
  return output;
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
      String[] load = split(join(loadStrings(resource), "").toLowerCase(), ".");
      for (int a = 0; a < load.length-1; a++) {
        for (int b = 0; b < vocabproc.length-1; b++) {
          if (split(load[a], " ")[round(random(split(load[a], " ").length-1))].indexOf(split(vocabproc[b], "\n")[round(random(split(vocabproc[b], "\n").length-1))]) > -1 && vocabStr.indexOf(vocabproc[b]) == -1) {
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
