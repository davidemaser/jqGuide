# jqGuide#
####v0.2####
---
#####Created by David Maser

MIT License
---

jqGuide is a jquery plugin that will  create a one page guide document from data collected from a json source.
###USE
Add the plugin js to your page after the jquery js script tag and add this code to the body of an HTML page.
```javascript
<script>
$().jqguide({
        jsonSourceFolder:"data_folder",
        jsonSourceData:"json_file",
        parentItem:"tag",//i.e. body, #someID
        createNav:true,//boolean -- Do you want the plugin to create a left nav of all the items
        showProgress:true//boolean -- Shows a document scroll progress bar. Useful if you have a lot of data
    });
</script>
```
###JSON FORMAT
Make sure your JSON file uses this format. Add more fields if you need and extend the extension to display them
```json
{
  "element":[
    {
      "name":"element name",
      "action":"action it executes",
      "scope":"element scope",
      "line":1,
      "description":"Description here",
      "parameters":[
        {
          "name":"param",
          "value":"array",
          "definition":"define what it does",
          "required":boolean
        }
      ],
      "returns":"what does it return",
      "dependencies":[
        {
          "item":"another element",
          "type":"element type"
        }
      ]
    }
  ]
}
```
