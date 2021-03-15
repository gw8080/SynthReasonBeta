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
  int memTries = 5000;
  int vocabScan = 50;
  String resource = "cyb.txt";// knowledgebase
  String rules = "uber.txt";// rules
  String allWords = "words.txt";// rules
  String vocabsyn = loadVocabFiles(30, resource);
  //String unknownWords = loadUnknowns(vocabsyn, rules, resource, allWords);
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
    String[]cat = split(catfull[catPos2], ",");
    String outputprep = "";
    String res = join(loadStrings(resource), "");
    for (int catPos = 0; catPos != cat.length-1; catPos++)
    {
      int x = round(random(split(vocabprep[int (cat[catPos])], "\n").length-1));
      for (int y = 0; y < memTries; y++) {
        if (res.indexOf(split(outputprep, " ")[split(outputprep, " ").length-1] + " " + split(vocabprep[int (cat[catPos])], "\n")[x]) > x) {
          outputprep += split(vocabprep[int (cat[catPos])], "\n")[x] + " "; 
          break;
        }
        x = round(random(split(vocabprep[int (cat[catPos])], "\n").length-1));
      }
    }
    output += outputprep + ".\n";
  }
  return output;
}
String loadUnknowns(String vocabsyn, String rules, String resource, String uWords) {
  String unknownWordsa = "";
  String unknownWordsb = "";
  String unknownWordsc = "";
  String[] testUnknown = loadStrings(uWords);
  String testResource = join(loadStrings(resource), "").toLowerCase();
  String[] suffix = loadStrings("suffixa.txt");
  for (int a = 0; a < testUnknown.length; a++) {
    if (testResource.indexOf(testUnknown[a]) > -1 && testUnknown[a].length() > 3) {
      if (vocabsyn.indexOf("\n" + testUnknown[a] + "\n") == -1) {
        for (int b = 0; b < suffix.length; b++) {
          if (testUnknown[a].indexOf(suffix[b]) > -1) {
            unknownWordsa += "\n" + testUnknown[a] + "\n";
            break;
          }
        }
      }
    }
  }
  suffix = loadStrings("suffixb.txt");
  for (int a = 0; a < testUnknown.length; a++) {
    if (testResource.indexOf(testUnknown[a]) > -1 && testUnknown[a].length() > 3) {
      if (vocabsyn.indexOf("\n" + testUnknown[a] + "\n") == -1) {
        for (int b = 0; b < suffix.length; b++) {
          if (testUnknown[a].indexOf(suffix[b]) > -1) {
            unknownWordsb += "\n" + testUnknown[a] + "\n";
            break;
          }
        }
      }
    }
  }
  suffix = loadStrings("suffixc.txt");
  for (int a = 0; a < testUnknown.length; a++) {
    if (testResource.indexOf(testUnknown[a]) > -1 && testUnknown[a].length() > 3) {
      if (vocabsyn.indexOf("\n" + testUnknown[a] + "\n") == -1) {
        for (int b = 0; b < suffix.length; b++) {
          if (testUnknown[a].indexOf(suffix[b]) > -1) {
            unknownWordsc += "\n" + testUnknown[a] + "\n";
            break;
          }
        }
      }
    }
  }
  return unknownWordsa + ":::::" + unknownWordsb + ":::::" +unknownWordsc + ":::::";
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
          if (load[a].equals(vocabproc[b]) == true) {
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
  String[]enx = split(join(loadStrings(rules), ""), ".");
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
