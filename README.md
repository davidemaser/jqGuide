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
