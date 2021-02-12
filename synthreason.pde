/*  //<>// //<>//
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
String problemF = "problem.txt";
String filterF = "filter.txt";
String contextF = "context.txt";
String output = "";
int threshold = 100;
void setup()
{
  String[] res = split(join(loadStrings(resource), ""), ".");
  String resStr = join(loadStrings(resource), "");
  String[] problem = split(join(loadStrings(problemF), "\n"), "\n");
  String filter = join(loadStrings(filterF), "\n");
  String[] filterA = loadStrings(filterF);
  String[] contextA = loadStrings(contextF);
  outputx = createWriter("output.txt");
  while (true) {
    String output = returnWords(problem, res, resStr, filter, filterA, contextA); 
    outputx.print(output);
    outputx.flush();
  }
}
String returnWords(String[] problem, String[] res, String resStr, String filter, String[] filterA, String[] context) {
  String output = "";
  boolean exit = false;
  for (int a = 0; a < 100 && exit == false; a++) {
    String funct = problem[round(random(problem.length-1))];
    int stat = 0;
    for (int b = 0; b < 100 && exit == false; b++) {
      String oneA = res[round(random(res.length-1))];
      String oneB = res[round(random(res.length-1))];
      String[] countA = split(oneA, " ");
      String[] countB = split(oneB, " ");
      for (int c = 0; c < 100 && exit == false; c++) {
        String testA = countA[round(random(countA.length-1))];
        String testB = countB[round(random(countB.length-1))];
        if ( testA.equals(testB) == true ) {
          stat++;
        }
        if (stat > threshold && oneA.indexOf(funct) > -1 && oneB.indexOf(funct) > -1 && funct.equals(testA) == false && filter.indexOf(testA) == -1 && filter.indexOf(funct) == -1) {
          boolean exit2 = false;
          for (int x = 0; x < 100 && exit2 == false; x++) {
            int rand = round(random(res.length-1));
            for (int y = 0; y < 100 && exit2 == false; y++) {
              int rand2 = round(random(context.length-1));
              if (res[rand].indexOf(funct) > -1 && res[rand].indexOf(context[rand2]) > -1 && res[rand].indexOf(testA) > -1) {
                output = funct + " is used in " + context[rand2] + " of " + testA + "\n";
                exit2 = true;
              }
            }
          }

          exit = true;
        }
      }
    }
  }  
  return output;
}
