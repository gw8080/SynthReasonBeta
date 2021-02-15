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
String useF = "use.txt";
String output = "";
int threshold = 20;
int scanLength = 1000;
void setup()
{
  String[] res = split(join(loadStrings(resource), ""), ".");
  String resStr = join(loadStrings(resource), "");
  String[] problem = split(join(loadStrings(problemF), "\n"), "\n");
  String filter = join(loadStrings(filterF), "\n");
  String[] filterA = loadStrings(filterF);
  String[] contextA = loadStrings(contextF);
  String[] useA = loadStrings(useF);
  outputx = createWriter("output.txt");
  while (true) {
    String output = returnWords(problem, res, resStr, filter, filterA, contextA, useA); 
    outputx.print(output);
    outputx.flush();
  }
}
String returnWords(String[] problem, String[] res, String resStr, String filter, String[] filterA, String[] context, String[] use) {
  String output = "";
  boolean exit = false;
  for (int a = 0; a < scanLength && exit == false; a++) {
    String funct = problem[round(random(problem.length-1))];
    int stat = 0;
    for (int b = 0; b < scanLength && exit == false; b++) {
      String oneA = res[round(random(res.length-1))];
      String oneB = res[round(random(res.length-1))];
      String[] countA = split(oneA, " ");
      String[] countB = split(oneB, " ");
      for (int c = 0; c < scanLength && exit == false; c++) {
        String testA = countA[round(random(countA.length-1))];
        String testB = countB[round(random(countB.length-1))];
        if ( testA.equals(testB) == true ) {
          stat++;
        }
        if (stat > threshold && oneA.indexOf(funct) > -1 && oneB.indexOf(funct) > -1 && funct.equals(testA) == false && filter.indexOf(testA) == -1 && filter.indexOf(funct) == -1) {
          boolean exit2 = false;
          for (int x = 0; x < scanLength && exit2 == false; x++) {
            int rand = round(random(res.length-1));
            for (int y = 0; y < scanLength && exit2 == false; y++) {
              int rand2 = round(random(context.length-1));
              if (res[rand].indexOf(funct) > -1 && res[rand].indexOf(context[rand2]) > -1 && res[rand].indexOf(testA) > -1) {
                for (int z = 0; z < scanLength && exit2 == false; z++) {
                  int rand3 = round(random(use.length-1));
                  if ( res[rand].indexOf(use[rand3]) > -1 ) {
                    for (int z2 = 0; z2 < scanLength && exit2 == false; z2++) {
                      int rand4 = round(random(filterA.length-1));
                      int rand5 = round(random(filterA.length-1));
                      int rand6 = round(random(filterA.length-1));
                      if ( resStr.indexOf(funct + " " + filterA[rand4]) > -1 &&  resStr.indexOf(filterA[rand5] + " " + context[rand2]) > -1 && resStr.indexOf(filterA[rand6] + " " + testA) > -1) {
                        output = funct + " " + filterA[rand4] + " " + use[rand3] + " " + filterA[rand5] + " " + context[rand2] + " " + filterA[rand6] + " " + testA + "\n";
                        exit2 = true;
                      }
                    }
                  }
                }
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
