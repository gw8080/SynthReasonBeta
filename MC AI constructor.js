
var str = "";
function OnStart() {
   lay = app.CreateLayout("Linear", "Vertical,FillXY")
   lay.SetChildMargins(0.01, 0.01, 0.01, 0.01)



   var resource = "/sdcard/exp.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split(" ");
   var x = Math.floor(Math.random() * (en.length)) + 0;
   app.ShowPopup( en[x] );
   str = en[x];
   btnLoad = app.CreateButton("is a concept", 0.43, 0.1);
   btnLoad.SetOnTouch(btnLoad_OnTouch);
   lay.AddChild(btnLoad);
   btnLoad1= app.CreateButton("is an action", 0.43, 0.1);
   btnLoad1.SetOnTouch(btnLoad1_OnTouch);
   lay.AddChild(btnLoad1);
    btnLoad2 = app.CreateButton("is a part of the mind", 0.43, 0.1);
   btnLoad2.SetOnTouch(btnLoad2_OnTouch);
   lay.AddChild(btnLoad2);
     btnLoad2a = app.CreateButton("is a part of the environment", 0.43, 0.1);
   btnLoad2a.SetOnTouch(btnLoad2a_OnTouch);
   lay.AddChild(btnLoad2a);
    btnLoad3 = app.CreateButton("Yes", 0.43, 0.1);
   btnLoad3.SetOnTouch(btnLoad3_OnTouch);
   lay.AddChild(btnLoad3);
    btnLoad4 = app.CreateButton("No", 0.43, 0.1);
   btnLoad4.SetOnTouch(btnLoad4_OnTouch);
   lay.AddChild(btnLoad4);
   btnSkip = app.CreateButton("skip", 0.43, 0.1);
   btnSkip.SetOnTouch(btnSkip_OnTouch);
   lay.AddChild(btnSkip);
    btnCombo = app.CreateButton("Do combo", 0.43, 0.1);
   btnCombo.SetOnTouch(btnCombo_OnTouch);
   lay.AddChild(btnCombo);
   app.AddLayout(lay);

}


function btnSkip_OnTouch() {

   var resource = "/sdcard/exp.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split(" ");
   var x = Math.floor(Math.random() * (en.length)) + 0;
   app.ShowPopup( en[x] );
   str = en[x];
}

function btnCombo_OnTouch() {

   var resource = "/sdcard/mind.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split("\n");
   var x = Math.floor(Math.random() * (en.length)) + 0;
     var resource = "/sdcard/action.txt";
    var KB2 = app.ReadFile(resource);
   var en2 = KB2.split("\n");
   var y = Math.floor(Math.random() * (en2.length)) + 0;
   app.ShowPopup("does "  + en[x] + " do " + en2[y]);
   str =  en[x] + " does " + en2[y];
}
function btnLoad_OnTouch() {

   app.WriteFile("/sdcard/action.txt", str + "\n", "Append")
      var resource = "/sdcard/exp.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split(" ");
   var x = Math.floor(Math.random() * (en.length)) + 0;
   app.ShowPopup( en[x] );
   str = en[x];
}
function btnLoad1_OnTouch() {
  app.WriteFile("/sdcard/concept.txt", str + "\n", "Append")
      var resource = "/sdcard/exp.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split(" ");
   var x = Math.floor(Math.random() * (en.length)) + 0;
   app.ShowPopup( en[x] );
   str = en[x];
}

function btnLoad2_OnTouch() {
   app.WriteFile("/sdcard/mind.txt", str + "\n", "Append")
      var resource = "/sdcard/exp.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split(" ");
   var x = Math.floor(Math.random() * (en.length)) + 0;
   app.ShowPopup( en[x] );
   str = en[x];
}

function btnLoad2a_OnTouch() {
 app.WriteFile("/sdcard/environment.txt", str + "\n", "Append")
      var resource = "/sdcard/exp.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split(" ");
   var x = Math.floor(Math.random() * (en.length)) + 0;
   app.ShowPopup( en[x] );
   str = en[x];
}

function btnLoad3_OnTouch() {
 app.WriteFile("/sdcard/correct.txt", str + "\n", "Append")
   var resource = "/sdcard/mind.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split("\n");
   var x = Math.floor(Math.random() * (en.length)) + 0;
     var resource = "/sdcard/action.txt";
    var KB2 = app.ReadFile(resource);
   var en2 = KB2.split("\n");
   var y = Math.floor(Math.random() * (en2.length)) + 0;
   app.ShowPopup("does "  + en[x] + " do " + en2[y]);
   str =  en[x] + " does " + en2[y];
}

function btnLoad4_OnTouch() {
   app.WriteFile("/sdcard/incorrect.txt", str + "\n", "Append")
   var resource = "/sdcard/mind.txt";
   var KB = app.ReadFile(resource);
   var en = KB.split("\n");
   var x = Math.floor(Math.random() * (en.length)) + 0;
     var resource = "/sdcard/action.txt";
    var KB2 = app.ReadFile(resource);
   var en2 = KB2.split("\n");
   var y = Math.floor(Math.random() * (en2.length)) + 0;
   app.ShowPopup("does "  + en[x] + " do " + en2[y]);
   str =  en[x] + " does " + en2[y];
}