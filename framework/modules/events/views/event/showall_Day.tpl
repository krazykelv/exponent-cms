{*
 * Copyright (c) 2004-2013 OIC Group, Inc.
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

{uniqueid prepend="cal" assign="name"}

{css unique="cal" link="`$asset_path`css/calendar.css"}

{/css}

<div class="module events viewday">
	<div class="module-actions">
		{icon class="weekviewlink" action=showall view=showall_Week time=$time title='View Entire Week'|gettext text='View Week'|gettext}
        {nbsp count=2}|{nbsp count=2}
		{icon class="monthviewlink" action=showall time=$time title='View Entire Month'|gettext text='View Month'|gettext}
        {permissions}
            {if $permissions.manage}
                {nbsp count=2}|{nbsp count=2}
                  {icon class="adminviewlink" action=showall view='showall_Administration' time=$time text='Administration View'|gettext}
                  {if !$config.disabletags}
                      {nbsp count=2}|{nbsp count=2}
                      {icon controller=expTag class="manage" action=manage_module model='event' text="Manage Tags"|gettext}
                  {/if}
                  {if $config.usecategories}
                      {nbsp count=2}|{nbsp count=2}
                      {icon controller=expCat action=manage model='event' text="Manage Categories"|gettext}
                  {/if}
            {/if}
        {/permissions}
		{*{printer_friendly_link text='Printer-friendly'|gettext prepend='&#160;&#160;|&#160;&#160;'}*}
        {*{export_pdf_link prepend='&#160;&#160;|&#160;&#160;'}*}
	</div>
	<h1>
        {ical_link}
        {if $moduletitle && !($config.hidemoduletitle xor $smarty.const.INVERT_HIDE_TITLE)}{$moduletitle}{/if}
	</h1>
    {if $config.moduledescription != ""}
        {$config.moduledescription}
    {/if}
	{permissions}
		<div class="module-actions">
			{if $permissions.create}
				{icon class=add action=edit title="Add a New Event"|gettext text="Add an Event"|gettext}
			{/if}
		</div>
	{/permissions}
    <div id="popup">
        <a href="javascript:void(0);" class="nav module-actions" id="J_popup_closeable{$__loc->src|replace:'@':'_'}">{'Go to Date'|gettext}</a>
        <div id="day-{$name}">
            {include 'day.tpl'}
        </div>
    </div>
</div>

{script unique=$name|cat:'-popup' yui3mods=1}
{literal}
EXPONENT.YUI3_CONFIG.modules = {
    'gallery-calendar': {
        fullpath: '{/literal}{$asset_path}js/calendar.js{literal}',
        requires: ['node','calendar-css']
    },
    'calendar-css': {
        fullpath: EXPONENT.PATH_RELATIVE+'framework/modules/events/assets/css/default.css',
        type: 'css'
    }
}
YUI(EXPONENT.YUI3_CONFIG).use('node','gallery-calendar','io','node-event-delegate',function(Y){
	var today = new Date({/literal}{$time}{literal}*1000);
    var monthcal = Y.one('#day-{/literal}{$name}{literal}');
    var cfg = {
                method: "POST",
                headers: { 'X-Transaction': 'Load Day'},
                arguments : { 'X-Transaction': 'Load Day'}
            };
    src = '{/literal}{$__loc->src}{literal}';
    var sUrl = EXPONENT.PATH_RELATIVE+"index.php?controller=event&action=showall&view=day&ajax_action=1&src="+src;

	// Popup calendar
	var cal = new Y.Calendar('J_popup_closeable{/literal}{$__loc->src|replace:'@':'_'}{literal}',{
		popup:true,
		closeable:true,
		startDay:{/literal}{$smarty.const.DISPLAY_START_OF_WEEK}{literal},
		date:today,
		action:['click'],
//        useShim:true
	}).on('select',function(d){
		var unixtime = parseInt(d / 1000);
        {/literal}
        {if $config.ajax_paging}
            {literal}
                cfg.data = "time="+unixtime;
                var request = Y.io(sUrl, cfg);
                monthcal.setContent(Y.Node.create('<div class="loadingdiv">{/literal}{"Loading Day"|gettext}{literal}</div>'));
            {/literal}
        {else}
            {if ($smarty.const.SEF_URLS == 1)} {literal}
                window.location=eXp.PATH_RELATIVE+'event/showall/time/view/showall_Day/'+unixtime+'/src/{/literal}{$__loc->src}{literal}';
            {/literal} {else} {literal}
                window.location=eXp.PATH_RELATIVE+'index.php?controller=event&action=showall&view=showall_Day&time='+unixtime+'&src={/literal}{$__loc->src}{literal}';
            {/literal} {/if}
        {/if}
        {literal}
	});
    Y.one('#J_popup_closeable{/literal}{$__loc->src|replace:'@':'_'}{literal}').on('click',function(d){
        cal.show();
    });

    // ajax load new month
	var handleSuccess = function(ioId, o){
		Y.log("The success handler was called.  Id: " + ioId + ".", "info", "monthcal nav");

        if(o.responseText){
            monthcal.setContent(o.responseText);
            monthcal.all('script').each(function(n){
                if(!n.get('src')){
                    eval(n.get('innerHTML'));
                } else {
                    var url = n.get('src');
                    if (url.indexOf("ckeditor")) {
                        Y.Get.script(url);
                    };
                };
            });
            monthcal.all('link').each(function(n){
                var url = n.get('href');
                Y.Get.css(url);
            });
            Y.one('#lb-bg').setStyle('display','none');
//            monthcal.setStyle('opacity',1);
        } else {
            Y.one('#month-{/literal}{$name}{literal}.loadingdiv').remove();
            monthcal.setContent('Unable to load content');
            monthcal.setStyle('opacity',1);
        }
	};

	//A function handler to use for failed requests:
	var handleFailure = function(ioId, o){
		Y.log("The failure handler was called.  Id: " + ioId + ".", "info", "monthcal nav");
	};

	//Subscribe our handlers to IO's global custom events:
	Y.on('io:success', handleSuccess);
	Y.on('io:failure', handleFailure);

{/literal}
{if $config.ajax_paging}
    {literal}
    monthcal.delegate('click', function(e){
        e.halt();
        cfg.data = "time="+e.currentTarget.get('rel');
        var request = Y.io(sUrl, cfg);
        monthcal.setContent(Y.Node.create('<div class="loadingdiv">{/literal}{"Loading Day"|gettext}{literal}</div>'));
//        monthcal.setStyle('opacity',0.5);
//        Y.one('#lb-bg').setStyle('display','block');
    }, 'a.nav');
    {/literal}
{/if}
{literal}

});
{/literal}
{/script}
