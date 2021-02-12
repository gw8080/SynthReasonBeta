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
String output = "";
int threshold = 100;
void setup()
{
  String[] res = split(join(loadStrings(resource), ""), ".");
  String resStr = join(loadStrings(resource), "");
  String[] problem = split(join(loadStrings(problemF), "\n"), "\n");
  String filter = join(loadStrings(filterF), "\n");
  String[] filterA = loadStrings(filterF);
  outputx = createWriter("output.txt");
  while (true) {
    String output = returnWords(problem, res, resStr, filter, filterA); 
    outputx.println(output);
    outputx.flush();
  }
}
String returnWords(String[] problem, String[] res, String resStr, String filter, String[] filterA) {
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
        if (stat > threshold && oneA.indexOf(funct) > -1 && oneB.indexOf(funct) > -1 && filter.indexOf(testA) == -1 && filter.indexOf(funct) == -1) {
          output = funct + " is used in context of " + testA;
          if (oneA.indexOf(funct) < oneA.indexOf(testA) && oneB.indexOf(funct) < oneB.indexOf(testA)) {
            output += " and " + funct + " preceeds " + testA + " in sentences.";
          }
          if (oneA.indexOf(funct) > oneA.indexOf(testA) && oneB.indexOf(funct) > oneB.indexOf(testA)) {
            output += " and " + testA + " preceeds " + funct + " in sentences. ";
          }
          exit = true;
        }
      }
    }
  }  
  return output;
}
