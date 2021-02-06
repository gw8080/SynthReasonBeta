/*  //<>//
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
String resource = "exp.txt";
String rules = "reason.txt";
String output = "";
String txt = "";
int size = 1000;
void setup()
{
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < 4000; count++)
  {
    vocabproc = loadStrings("node/" + count + ".txt");
    if (vocabproc != null)
    {
      String voc = join(vocabproc, " ");
      if (voc.length() > 0)
      {
        vocabsyn += voc + ":::::";
      }
    }
  }
  outputx = createWriter("vocab.txt");
  outputx.println(vocabsyn);
  outputx.close();
  String[]KB = loadStrings(rules);
  String str = join(KB, "");
  String[]enx = split(str, " ");
  String[]vocabprep = vocabsyn.split(":::::");
  for (int x = 0; x < enx.length; x++)
  {
    for (int y = 0; y < vocabprep.length; y++)
    {
      if (vocabprep[y].indexOf(" " + enx[x] + " ") > -1)
      {
        txt += y + ":" + x + ",";
        break;
      }
    }
  }
  outputx = createWriter("rules.txt");
  outputx.println(txt);
  outputx.close();
  str = "";
  String[]cat = txt.split(",");
  for (int n = 0; n != cat.length-1; n++)
  {
    String[] words = split(vocabprep[int (split(cat[n], ":")[0])], " ");
    String[] word = loadStrings("node/" + words[round(random(words.length-1))] + ".txt");
    if (word != null) {
      output += words[round(random(words.length-1))] + " " + word[round(random(word.length-1))] + " ";
    }
  }
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.close();
  exit();
}
