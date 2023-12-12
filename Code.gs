function toJson(json, tab, sheet) {
  // Browser.msgBox(sheet.getLastRow());
  // console.log(sheet.getRange(1,1).getValue());
  var key, file;
  json[tab]={};
  for (var i=1; i<=sheet.getLastRow(); i++) {
    var r1=sheet.getRange(i, 1);
    var c1=r1.getValue();
    if (!r1.isBlank())
      key=c1;
    var r2=sheet.getRange(i, 2);
    if (r2.isBlank())
      continue;
    var c2=r2.getValue();
    if (r2.getBackgrounds()[0]=="#ffffff")
      continue;
    if (key in json[tab])
      json[tab][key]+=c2;
    else
      json[tab][key]=c2;
    // console.log(key,c2);
  }
}

function doPOST() {
  var pub=SpreadsheetApp.getActiveSpreadsheet().getSheetByName("publications");
  var news=SpreadsheetApp.getActiveSpreadsheet().getSheetByName("news");
  if (pub == null || news==null) {
    Browser.msgBox("No data.");
    return;
  }

  var json={};
  toJson(json, "publications", pub);
  toJson(json, "news", news);
  console.log(json);

  var url = "http://renlab.sdsc.edu/renlab_docker/web.php";
  
  var options = { "method":"POST",
    "contentType" : "application/json",
    "headers" : { "Accept":"application/json" },
    "payload" : JSON.stringify(json, null, 4)
  };

  var response = UrlFetchApp.fetch(url, options);
  Logger.log(response); 
  var response_json = JSON.parse(response);
  console.log(response_json);
}

function onOpen() {
  var ui = SpreadsheetApp.getUi();
  var menu = ui.createMenu('Renlab');

  menu.addItem("POST", "doPOST").addToUi();
};
