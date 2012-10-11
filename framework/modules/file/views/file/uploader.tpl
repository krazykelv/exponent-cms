{*
 * Copyright (c) 2004-2012 OIC Group, Inc.
 *
 * This file is part of Exponent
 *
 * Exponent is free software; you can redistribute
 * it and/or modify it under the terms of the GNU
 * General Public License as published by the Free
 * Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * GPL: http://www.gnu.org/licenses/gpl.txt
 *
 *}

<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>{'File Uploader'|gettext}  |  Exponent CMS</title>
    {css unique="uploader" corecss="msgq,button,tables,common,admin-global" link="`$asset_path`css/filemanager.css"}

    {/css}
    <script type="text/javascript" src="{$smarty.const.PATH_RELATIVE}exponent.js2.php"></script>
    <script type="text/javascript" src="{$smarty.const.YUI3_RELATIVE}yui/yui-min.js"></script>
    {script unique="picker" src="`$smarty.const.JS_RELATIVE`exp-flashdetector.js"}

    {/script}
</head>
<body class="exp-skin">
<div id="exp-uploader">
    <h1>{"Upload Files"|gettext}</h1>
    <div id="actionbar">
    	<div id="uploaderOverlay" style="position:absolute; z-index:2"></div> 
    	<a class="select awesome small green" style="z-index:1" id="selectLink" href="#"><span>{'Select Files'|gettext}</span></a>
        <a id="uploadLink" class="upload awesome small green" href="#"><span>{"Upload Files"|gettext}</span></a>
        <a id="backlink" class="back awesome small green" href="{link action=picker ajax_action=1 ck=$smarty.get.ck update=$smarty.get.update fck=$smarty.get.fck}{if $smarty.const.SEF_URLS}?{else}&{/if}CKEditor={$smarty.get.CKEditor}&CKEditorFuncNum={$smarty.get.CKEditorFuncNum}&langCode={$smarty.get.langCode}"><span>{'Back to Manager'|gettext}</span></a>
    </div>
	<div class="info-header clearfix">
		<div id="noflash"></div>
		
		<div class="related-actions">
			{help text="Get Help"|gettext|cat:" "|cat:("Uploading Files"|gettext) module="upload-files"}
		</div>

	</div>    
    {messagequeue}

    <div id="dataTableContainer">
      <table id="filenames" class="exp-skin-table">
        <thead>
    	   <tr><th>{'Filename'|gettext}</th><th>{'File size'|gettext}</th><th>{'Percent uploaded'|gettext}</th></tr>
    	</thead>
    	<tbody>
    	</tbody>
      </table>	
    </div>

</div>

{script unique="uploader"}
{literal}
YUI(EXPONENT.YUI3_CONFIG).use('node','uploader-deprecated', function(Y) {
    var uploader,
        selectedFiles = {};

    var usr = {/literal}{obj2json obj=$user}{literal}; //user

    function init () {
        var overlayRegion = Y.one("#selectLink").get('region');
        Y.one("#uploaderOverlay").set("offsetWidth", overlayRegion.width);
        Y.one("#uploaderOverlay").set("offsetHeight", overlayRegion.height);

        var swfURL = EXPONENT.YUI3_RELATIVE + "uploader-deprecated/assets/uploader.swf";

        if (Y.UA.ie >= 6) {
        	swfURL += "?t=" + Y.guid();
        }

        uploader = new Y.Uploader({boundingBox:"#uploaderOverlay", 
                                   swfURL: swfURL});	

        uploader.on("uploaderReady", setupUploader);
        uploader.on("fileselect", fileSelect);
        uploader.on("uploadprogress", updateProgress);
        uploader.on("uploadcomplete", uploadComplete);
    }

    Y.on("domready", init);

    function setupUploader (event) {
    	uploader.set("multiFiles", true);
    	uploader.set("simLimit", 3);
    	uploader.set("log", true);
                                
    	var fileFilters = new Array({description:"All Files", extensions:"*.*;"}); 
    	
        // var fileFilters = new Array({description:"Images", extensions:"*.jpg;*.png;*.gif"},
        //                    {description:"Videos", extensions:"*.avi;*.mov;*.mpg"}); 

        uploader.set("fileFilters", fileFilters); 
    }

    var rowcolor = 'odd';
    function fileSelect (event) {
    	var fileData = event.fileList;	
        
    	for (var key in fileData) {
            rowcolor = (rowcolor=='odd')?'even':'odd';
	        if (!selectedFiles[fileData[key].id]) {
			   var output = "<tr class=\""+rowcolor+"\"><td>" + fileData[key].name + "</td><td>" + 
			                (Math.round(fileData[key].size/1048576*100000)/100000).toFixed(2) + "</td><td><div id='div_" + 
			                fileData[key].id + "' class='progressbars'></div></td></tr>";
			   Y.one("#filenames tbody").append(output);

               // var progressBar = new Y.ProgressBar({id:"pb_" + fileData[key].id, layout : '<div class="{labelClass}"></div><div class="{sliderClass}"></div>'});
               //     progressBar.render("#div_" + fileData[key].id);
               //     progressBar.set("progress", 0);

               var progressBar = Y.Node.create("<div style='width:90%;background-color:#CCC;padding:3px;'><div style='height:12px;padding:0px;font-size:10px;color:#fff;background-color:#900;width:0;'>0%</div></div>");
               Y.one("#div_" + fileData[key].id).setContent(progressBar);

               selectedFiles[fileData[key].id] = true;
			}
    	}
    }

    function updateProgress (event) {
		//var rowNum = fileIdHash[event["id"]];
		var prog = Math.round(100 * (event.bytesLoaded / event.bytesTotal));
		var progbar = "<div style='width:90%;background-color:#CCC;'><div style='height:12px;padding:3px;font-size:10px;color:#fff;background-color:"+((prog>90)?'#fad00e':'#b30c0c')+";width:" + prog + "%;'>" + prog + "%</div></div>";
        Y.one("#div_" + event.id).setContent(progbar);

        // var pb = Y.Widget.getByNode("#pb_" + event.id);
        // pb.set("progress", Math.round(100 * event.bytesLoaded / event.bytesTotal));
    }

    function uploadComplete (event) {
		var progbar = "<div style='width:90%;background-color:#CCC;'><div style='height:12px;padding:3px;font-size:10px;color:#fff;background-color:#2f840a;width:100%;'><img src='"+EXPONENT.PATH_RELATIVE+"framework/core/assets/images/accepted.png' style=\"float:right; margin:-3px -24px 0 0\">100%</div></div>";
        Y.one("#div_" + event.id).setContent(progbar);
    }

    function uploadFiles (event) {

//    	if (selectedFiles != null) {
//    		uploader.setSimUploadLimit(parseInt(3));
//          uploader.uploadAll(EXPONENT.PATH_RELATIVE+"index.php?controller=file&action=upload&ajax_action=1");
            uploader.uploadAll(EXPONENT.PATH_RELATIVE+"index.php?controller=file&action=upload&ajax_action=1&usrid=" + usr['id']);
//      }
//        uploader.uploadAll("http://www.yswfblog.com/upload/upload_simple.php");
    }

    Y.one("#uploadLink").on("click", uploadFiles);

    Y.all('.msg-queue .close').on('click',function(e){
        e.halt();
        e.target.get('parentNode').remove();
    });
	
	if(!FlashDetect.installed) { 
		Y.one('#noflash').append('You need to have Adobe Flash Player installed in your browser to upload files.<br /><a href="http://get.adobe.com/flashplayer/" target="_blank">Download it from Adobe.</a>');   
	}
	
});
{/literal}
{/script}
</body>
</html>
