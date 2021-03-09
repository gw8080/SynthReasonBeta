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
String resource = "exp.txt";// knowledgebase
String rules = "reason.txt";// rules
String output = "";
String txt = "";
void setup()
{
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < 25; count++)
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
  String[]enx = split(join(loadStrings(rules), ""), ".");
  String[]vocabprep = vocabsyn.split(":::::");
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
  String str = join(loadStrings(resource), "");
  String[]en = split(str, " ");
  String[]catfull = split(txt, "::");



  outputx = createWriter("output.txt");
  for (int catPos2 = 0; catPos2 != catfull.length-1; catPos2++)
  {
    String[]cat = split(catfull[catPos2], ",");
    for (int catPos = 0; catPos != cat.length-1; catPos++)
    {
      for (int enPos = round(random(en.length)); enPos < en.length-2; enPos++)
      {
        if (vocabprep[int (cat[catPos])].indexOf("\n" + en[enPos] + "\n") > -1) {
          output += en[enPos] + " " ; 
          enPos = round(random(en.length));
          break;
        }
      }
    }
    output += ".\n";
  }
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}
boolean select(String[] en, String[] vocabprep, String[] cat, int enPos, int catPos, int relPos) {
  boolean state = false;
  if (vocabprep[int (cat[catPos+relPos])].indexOf("\n" + en[enPos+relPos] + "\n") > -1) {
    state = true;
  }
  return state;
}
