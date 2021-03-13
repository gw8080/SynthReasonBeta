/* 
 Copyright (C) 2020 George Wagenknecht SynthReason, This program is free
 software; you can redistribute it and/or modify it under the terms of the
 GNU General Public License as published by the Free Software Foundation;
 either version 2 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT 
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 more details. You should have received a copy of the GNU General Public
 License along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA */

PrintWriter outputx;
PrintWriter debug;
void setup()
{
  String output = "";
  int memTries = 500;
  int vocabScan = 50;
  String resource = "reason.txt";// knowledgebase
  String rules = "reason.txt";// rules
  String allWords = "words.txt";// rules
  String vocabsyn = loadVocabFiles(30);
  // String unknownWords = loadUnknowns(vocabsyn, rules, resource, allWords);
  //vocabsyn += unknownWords + ":::::";
  String[]vocabprep = vocabsyn.split(":::::");
  String rulesReady = processRules(vocabprep, rules);
  String[]catfull = split(rulesReady, "::");
  output = processSentences(catfull, resource, vocabprep, memTries, vocabScan);
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}

String processSentences(String[] catfull, String resource, String[] vocabprep, int memTries, int vocabScan) {
  String output = "";
  for (int catPos2 = 0; catPos2 != catfull.length-1; catPos2++)
  {
    String outputprep = "";
    String[]cat = split(catfull[catPos2], ",");  
    for (int catPos = 0; catPos != cat.length-1; catPos++)
    {
      outputprep += split(vocabprep[int (cat[catPos])], "\n")[round(random(split(vocabprep[int (cat[catPos])], "\n").length-1))] + " " ;
    }
    output += outputprep + ".\n";
  }

  return output;
}
String loadUnknowns(String vocabsyn, String rules, String resource, String uWords) {
  String unknownWords = "";
  String[] testUnknown = loadStrings(uWords);
  String testResource = join(loadStrings(resource), "");
  String testRules = join(loadStrings(rules), "");
  for (int a = 0; a < testUnknown.length; a++) {
    if (testResource.indexOf(" " + testUnknown[a] + " ") > -1 || testRules.indexOf(" " + testUnknown[a] + " ") > -1) {
      if (vocabsyn.indexOf("\n" + testUnknown[a] + "\n") == -1) {
        unknownWords += "\n" + testUnknown[a] + "\n";
      }
    }
  }
  return unknownWords;
}
String loadVocabFiles(int MAX) {
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < MAX; count++)
  {
    vocabproc = loadStrings(count + ".txt");
    if (vocabproc != null)
    {
      String voc = join(vocabproc, '\n');
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
  String[]enx = split(join(loadStrings(rules), ""), ".");
  for (int z = 0; z < enx.length; z++)
  {
    String[]enwords = split(enx[z], " ");
    for (int x = 0; x < enwords.length; x++)
    {
      for (int y = 0; y < vocabprep.length; y++)
      {
        if (vocabprep[y].indexOf("\n" + enwords[x] + "\n") > -1)
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
