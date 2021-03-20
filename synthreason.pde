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
  int checkTries = 5000;
  int vocabScan = 50;
  int matchTries = 100;
  int matchSuccess = 80;
  String resource = "exp.txt";// knowledgebase
  String rules = "reason.txt";// rules
  String allWords = "words.txt";// rules
  String vocabsyn = loadVocabFiles(30, resource);
  //String unknownWords = loadUnknowns(vocabsyn, rules, resource, allWords);
  //vocabsyn += unknownWords + ":::::";
  String[]vocabprep = vocabsyn.split(":::::");


  String[] rulesArray = processRules(vocabprep, rules);
  String rulesReady = rulesArray[0];
  String navReady = rulesArray[1];
  String[]catfull = split(rulesReady, "::");
  String[]navfull = split(navReady, "::");
  output = processSentences(catfull, navfull, resource, vocabprep, matchTries, matchSuccess, checkTries);

  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}

String processSentences(String[] catfull, String[] navfull, String resource, String[] vocabprep, int matchTries, int matchSuccess, int checkTries) {
  String output = "";
  outputx = createWriter("debug.txt");
  for (int catPos2 = 0; catPos2 != catfull.length-1; catPos2++)
  {
    String[]cat = split(catfull[catPos2], ",");

    String outputprep = "";
    String res = "";
    if (cat.length-1 > 2) {
      for (int catPos = 0; catPos != cat.length-1; catPos++)
      {
        outputprep += split(vocabprep[int (cat[catPos])], "\n")[round(random(split(vocabprep[int (cat[catPos])], "\n").length-1))] + " ";
        res += vocabprep[int (cat[catPos])] + "::";
      }
    }

    String out = "";

    String[] res3 = split(res, "::");
    for (int y = 0; y < res3.length-1; y++) {
      String[]res2 = split(res3[y], "\n");
      for (int x = 0; x < res2.length-1; x++) {
        if (outputprep.indexOf(res2[x]) > -1 && res2[x].length() > 1) {
          out += res2[x] + " ";
          outputprep = outputprep.replace(res2[x], "");
          break;
        }
      }
    }


    output += out + "\n";
  }
  return output;
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
String[] processRules(String[] vocabprep, String rules) { 
  String txt = "", nav = "";
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
          nav += enwords[x] + ",";
          break;
        }
      }
    }
    txt += "::";
    nav += "::";
  }

  txt += ";;;;;" + nav;

  return split(txt, ";;;;;");
}
