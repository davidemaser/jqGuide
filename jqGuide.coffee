###*
# jqGuide v0.2
# Created by David Maser
# jqGuide is a jquery plugin that will
# create a one page guide document from
# data collected from a json source.
#
# To extend this plugin, first look at the json
# document format and add nodes to the output html
# in the ajax success object
#
###

(($) ->

    $.fn.jqguide = (options) ->
        htmlObj = ''
        settings = $.extend({
            jsonSourceFolder: null
            jsonSourceData: null
            parentItem: null
            createNav: false
            showProgress: true
        }, options)

        sortNav = ->
            $navParent = $('.nav-holder')
            $navItems = $navParent.children('.nav-line')
            $navItems.sort (a, b) ->
                an = a.getAttribute('data-scope')
                bn = b.getAttribute('data-scope')
                if an > bn
                    return 1
                if an < bn
                    return -1
                0
            $navItems.detach().appendTo $navParent
            return

        $(settings.parentItem).on 'click', '.nav-line', ->
            window.location = $(this).data('link')
            false
        styleBlock = '<style type="text/css">#left-panel:before,.item_title{text-align:center;font-size:40px}section#global{position:absolute;width:100%;height:100%}#left-panel,#main-panel{display:block;height:100%;position:relative;float:left;overflow-y:auto}#left-panel{width:20%;background:#afafbd}#left-panel:before{content:"Functions";display:block;padding:10px 5px}progress{position:fixed;left:0;bottom:0;width:100%;height:5px;z-index:99;-webkit-appearance:none;-moz-appearance:none;appearance:none;border:none;background-color:transparent;color:#cb0032}progress::-webkit-progress-bar{background-color:transparent}progress::-webkit-progress-value{background-color:#cb0032}progress::-moz-progress-bar{background-color:#cb0032}#main-panel:after{content:"Made using Dave Maser\'s awesome jqGuide";padding:40px 20px;font-size:12px}'
        if settings.createNav == true
            styleBlock += '#main-panel{width:80%}'
        else
            styleBlock += '#main-panel{width:100%}'
        styleBlock += '.nav-line{padding:5px 10px;transition:all .3s;cursor:pointer}.nav-line:hover{background:#ccc}.nav-line span:before{content:" > "}body{overflow:hidden}.item_layout{border-bottom:10px solid rgba(0,0,0,.5);margin-bottom:30px;border-left:10px solid rgba(204,204,204,.4);margin-left:20px}.item_title{display:block;padding:10px 5px}.inline{display:inline-block}.item_subline{padding:10px}.bub,.nub,.shrub,.stub{box-shadow:0 2px 0 rgba(0,0,0,.5);padding:5px}.inline.first{margin:10px 10px 10px 0}.line_item:before{content:"Line "}.return_item:before{content:"Returns -> "}.stub{margin:0 10px;background:#82d865}.nub{background:#9c89f6;color:#fff}.bub{background:#ddd}.nav-line span{text-decoration:none;color:#3e744f;transition:all .8s}.nav-line span:hover{color:#000;padding-left:5px}.line_param{margin:10px}.first.action_item:before{content:"action : ";color:#fff}.line_param:not(.first):not(:last-child):before{content:" -> "}.line_param:last-child:not(:only-of-type):before{content:"required = ";color:#ccc}.line_param.first{background:#d6c3f6;color:#000}.get_depends,.get_params{background:rgba(204,204,204,.4)}.get_params:before{content:"Parameters ";font-size:25px;color:#aaa}.get_depends:before{content:"Dependencies";font-size:25px;color:#aaa}.shrub{background:#cb0032;color:#fff}.browser:before,.core:before,.data:before,.utility:before{text-align:left;font-size:10px;display:inline-block;padding:10px 5px;background:rgba(255,255,255,.2)}.line_depends:not(.first):before{content:"@"}.line_depends[data-action=function]:before{content:"fun ";opacity:.5}.line_depends[data-action=variable]:before{content:"var ";opacity:.5}.line_depends[data-action=component]:before{content:"com ";opacity:.5}.line_depends[data-action=object]:before{content:"obj ";opacity:.5}.line_depends[data-action=prototype]:before{content:"pro ";opacity:.5}.line_depends[data-action=none]:before,.line_param[data-action=none]:before{content:"!! none !!";opacity:.5}.browser:before{content:"Browser"}.core:before{content:"Core"}.utility:before{content:"Utility"}.data:before{content:"Data"}</style>'
        $(styleBlock).insertAfter 'title'
        if settings.showProgress == true
            htmlObj = '<progress value="0"></progress><section id="global">'
        else
            htmlObj = '<section id="global">'
        if settings.createNav == true
            htmlObj += '<div id="left-panel"><div class="nav-holder"></div></div>'
        htmlObj += '<div id="main-panel"><div id="inner"></div></div>'
        htmlObj += '</section>'
        $(settings.parentItem).append htmlObj
        $.ajax
            url: settings.jsonSourceFolder + '/' + settings.jsonSourceData
            dataType: 'json'
            method: 'GET'
            success: (data) ->
                if settings.createNav == true
                    i = 0
                    while i < data['element'].length
                        $('.nav-holder').append '<div class="nav-line ' + data['element'][i]['scope'] + '" data-scope="' + data['element'][i]['scope'] + '" data-link="#' + data['element'][i]['name'] + '"><span>' + data['element'][i]['name'] + '</span></div>'
                        i++
                j = 0
                while j < data['element'].length
                    view = '<div class="item_layout">'
                    view += '<div class="item_title"><a id="' + data['element'][j]['name'] + '"></a>' + data['element'][j]['name'] + '</div>'
                    view += '<div class="item_subline"><div class="inline first action_item stub" title="What are you looking at!!!">' + data['element'][j]['action'] + '</div><div class="inline line_item stub">' + data['element'][j]['line'] + '</div></div>'
                    view += '<div class="item_subline">' + data['element'][j]['description'] + '</div>'
                    if typeof data['element'][j]['parameters'] == 'object' and data['element'][j]['parameters'] != null
                        view += '<div class="item_subline get_params">'
                        k = 0
                        while k < data['element'][j]['parameters'].length
                            view += '<div class="item_parameter"><div class="inline first line_param nub" title="What do you get when you cross a brown chicken with a brown cow ? Brown-Chicken-Brown-Cow">' + data['element'][j]['parameters'][k]['name'] + '</div><div class="inline line_param nub">' + data['element'][j]['parameters'][k]['value'] + '</div><div class="inline line_param nub">' + data['element'][j]['parameters'][k]['definition'] + '</div><div class="inline line_param nub">' + data['element'][j]['parameters'][k]['required'] + '</div></div>'
                            k++
                        view += '</div>'
                    else
                        view += '<div class="item_subline get_params"><div class="item_parameter"><div class="inline first line_param nub" data-action="none"></div></div></div>'
                    view += '<div class="item_subline"><div class="inline first return_item bub">' + data['element'][j]['returns'] + '</div></div>'
                    if typeof data['element'][j]['dependencies'] == 'object' and data['element'][j]['dependencies'] != null
                        view += '<div class="item_subline get_depends">'
                        l = 0
                        while l < data['element'][j]['dependencies'].length
                            view += '<div class="item_depends"><div class="inline first line_depends shrub" title="Because everyone needs someone they can depend on" data-action="' + data['element'][j]['dependencies'][l]['type'] + '">' + data['element'][j]['dependencies'][l]['item'] + '</div><div class="inline line_depends shrub">' + data['element'][j]['dependencies'][l]['type'] + '</div></div>'
                            l++
                        view += '</div>'
                    else
                        view += '<div class="item_subline get_depends"><div class="item_depends"><div class="inline first line_depends shrub" data-action="none"></div></div></div>'
                    view += '</div>'
                    $('#inner').append view
                    j++
                return
            complete: ->
                sortNav()
                winHeight = $('#main-panel').height()
                docHeight = $('#inner').height()
                progressBar = $('progress')
                max = undefined
                value = undefined

                ### Set the max scrollable area ###

                max = docHeight - winHeight
                progressBar.attr 'max', max
                $('#main-panel').on 'scroll', ->
                    console.log 'working'
                    value = $('#main-panel').scrollTop()
                    progressBar.attr 'value', value
                    return
                return
        return

    return
) jQuery