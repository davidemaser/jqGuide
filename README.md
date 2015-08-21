# jqGuide
jqGuide is a jquery plugin that will  create a one page guide document from data collected from a json source.
####USE
Add the plugin js to your page after the jquery js script tag and add this code to the body of an HTML page.
```javascript
$().jqguide({
        jsonSourceFolder:"data_folder",
        jsonSourceData:"json_file",
        parentItem:"html tag",
        createNav:true,//boolean
        showProgress:true//boolean
    });
```
```javascript
###JSON FORMAT
{
  "element":[
    {
      "name":"logChanges",
      "action":"writes",
      "scope":"utility",
      "line":67,
      "description":"Logs all changes brought to a handsontable instance",
      "parameters":[
        {
          "name":"change",
          "value":"array",
          "definition":"reads data from the handsontable change object",
          "required":true
        },
        {
          "name":"table",
          "value":"string",
          "definition":"text value of the table sending the log",
          "required":true
        },
        {
          "name":"method",
          "value":"string",
          "definition":"what method has sent the log data",
          "required":true
        }
      ],
      "returns":"array",
      "dependencies":[
        {
          "item":"change",
          "type":"object"
        }
      ]
    }
  ]
}
```javascript
