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
String search = "existence";// search
String output = "";
String txt = "";
void setup()
{
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < 20; count++)
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
  String[]enx = split(join(loadStrings(rules), ""), " ");
  String[]vocabprep = vocabsyn.split(":::::");
  for (int x = 0; x < enx.length; x++)
  {
    for (int y = 0; y < vocabprep.length; y++)
    {
      if (vocabprep[y].indexOf("\n" + enx[x] + "\n") > -1)
      {
        txt += y + ",";// load rules
        break;
      }
    }
  }
  String str = "";
  String[] KB = loadStrings(resource);
  for (int i = 0; i < KB.length; i++)
  {
    if (KB[i].indexOf(split(KB[0], " ")[round(random(split(KB[0], " ").length-1))]) > -1 || KB[i].indexOf(search) >-1) {
      str += KB[i];// load working memory
    }
  }
  String[]en = str.split(" ");
  String[]cat = txt.split(",");
  outputx = createWriter("output.txt");
  for (int catPos = 1; catPos != cat.length-3; catPos++)
  {
    for (int enPos = round(random(en.length)); enPos < en.length-2; enPos++)
    {
      if (select(en, vocabprep, cat, enPos, catPos, 1) == true && select(en, vocabprep, cat, enPos, catPos, -1) == true) {// check position
        if (str.indexOf(split(output, " ")[split(output, " ").length-1] + " " + en[enPos] ) > -1) {// word linking
          output += en[enPos] + " " ; 
          enPos = round(random(en.length));
          break;
        }
      }
    }
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
