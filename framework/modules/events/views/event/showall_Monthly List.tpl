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

{uniqueid prepend="cal" assign="name"}

{css unique="cal" link="`$asset_path`css/calendar.css"}

{/css}

{css unique="cal" link="`$asset_path`css/default.css"}

{/css}

<div class="module events monthly">
	<div class="module-actions">
		{icon class="monthviewlink" action=showall time=$time text='Calendar View'|gettext}
        {nbsp count=2}|{nbsp count=2}
        <span class="listviewlink"></span>{'List View'|gettext}
		{permissions}
			{if $permissions.manage == 1}
                {nbsp count=2}|{nbsp count=2}
                {icon class="adminviewlink mngmntlink" action=showall view=showall_Administration time=$time text='Administration View'|gettext}
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
        {printer_friendly_link text='Printer-friendly'|gettext prepend='&#160;&#160;|&#160;&#160;'}
        {export_pdf_link prepend='&#160;&#160;|&#160;&#160;'}
        {br}
	</div>
	<h1>
        {ical_link}
        {if $moduletitle && !$config.hidemoduletitle}{$moduletitle}{/if}
	</h1>
    {if $config.moduledescription != ""}
        {$config.moduledescription}
    {/if}
    {$myloc=serialize($__loc)}
	{permissions}
		<div class="module-actions">
			{if $permissions.create == 1}
				{icon class=add action=edit title="Add a New Event"|gettext text="Add an Event"|gettext}
			{/if}
		</div>
	{/permissions}
	<p class="caption">
		&laquo;&#160;
		<a class="module-actions calendar_mngmntlink" href="{link action=showall view='showall_Monthly List' time=$prev_timestamp3}" title="{$prev_timestamp3|format_date:"%B %Y"}">{$prev_timestamp3|format_date:"%b"}</a>&#160;&#160;&laquo;&#160;
		<a class="module-actions calendar_mngmntlink" href="{link action=showall view='showall_Monthly List' time=$prev_timestamp2}" title="{$prev_timestamp2|format_date:"%B %Y"}">{$prev_timestamp2|format_date:"%b"}</a>&#160;&#160;&laquo;&#160;
		<a class="module-actions calendar_mngmntlink" href="{link action=showall view='showall_Monthly List' time=$prev_timestamp}" title="{$prev_timestamp|format_date:"%B %Y"}">{$prev_timestamp|format_date:"%b"}</a>&#160;&#160;&laquo;&#160;&#160;&#160;&#160;&#160;
        <a class="module-actions" style="z-index:999;" href="javascript:void(0);" id="J_popup_closeable" title="{'Go to Date'|gettext}"><strong>{$time|format_date:"%B %Y"}</strong></a>&#160;&#160;&#160;&#160;&#160;&#160;&raquo;&#160;&#160;
		<a class="module-actions calendar_mngmntlink" href="{link action=showall view='showall_Monthly List' time=$next_timestamp}" title="{$next_timestamp|format_date:"%B %Y"}">{$next_timestamp|format_date:"%b"}</a>&#160;&#160;&raquo;&#160;
		<a class="module-actions calendar_mngmntlink" href="{link action=showall view='showall_Monthly List' time=$next_timestamp2}" title="{$next_timestamp2|format_date:"%B %Y"}">{$next_timestamp2|format_date:"%b"}</a>&#160;&#160;&raquo;&#160;
		<a class="module-actions calendar_mngmntlink" href="{link action=showall view='showall_Monthly List' time=$next_timestamp3}" title="{$next_timestamp3|format_date:"%B %Y"}">{$next_timestamp3|format_date:"%b"}</a>&#160;&#160;&raquo;
	</p>
	<dl class="viewweek">
		{foreach from=$days item=items key=ts}
			{if_elements array=$items}
				<dt>
					<div class="sectiontitle"><strong>
						<a class="itemtitle calendar_mngmntlink" href="{link action=showall view=showall_Day time=$ts}">{$ts|format_date:"%A, %b %e"}</a>
					</strong></div>
				</dt>
				<dd>
					{*{assign var=none value=1}*}
                    {$none=1}
					{foreach from=$items item=item}
						{*{assign var=none value=0}*}
                        {$none=0}
						<div class="paragraph">
							<a class="itemtitle{if $config.usecategories && !empty($item->color)} {$item->color}{/if}"
                                {if substr($item->location_data,1,8) != 'calevent'}
                                   href="{if $item->location_data != 'event_registration'}{link action=show date_id=$item->date_id}{else}{link controller=eventregistration action=showByTitle title=$item->title}{/if}"
                               {/if}
                               title="{$item->body|summarize:"html":"para"}">{$item->title}
                            </a>
							{permissions}
                                {if substr($item->location_data,0,3) == 'O:8'}
                                    <div class="item-actions">
                                        {if $permissions.edit == 1}
                                            {if $myloc != $item->location_data}
                                                {if $permissions.manage == 1}
                                                    {icon action=merge id=$item->id title="Merge Aggregated Content"|gettext}
                                                {else}
                                                    {icon img='arrow_merge.png' title="Merged Content"|gettext}
                                                {/if}
                                            {/if}
                                            {icon action=edit record=$item date_id=$item->date_id title="Edit this Event"|gettext}
                                        {/if}
                                        {if $permissions.delete == 1}
                                            {if $item->is_recurring == 0}
                                                {icon action=delete record=$item date_id=$item->date_id title="Delete this Event"|gettext}
                                            {else}
                                                {icon action=delete_form class=delete record=$item date_id=$item->date_id title="Delete this Event"|gettext}
                                            {/if}
                                        {/if}
                                    </div>
                                {/if}
							{/permissions}
							<div>
								{if $item->is_allday == 1}- {'All Day'|gettext}{else}
									{if $item->eventstart != $item->eventend}
										- {$item->eventstart|format_date:$smarty.const.DISPLAY_TIME_FORMAT} {'to'|gettext} {$item->eventend|format_date:$smarty.const.DISPLAY_TIME_FORMAT}
									{else}
										- {$item->eventstart|format_date:$smarty.const.DISPLAY_TIME_FORMAT}
									{/if}
								{/if}
								{br}
								{$item->summary}
							</div>
						</div>
					{/foreach}
				</dd>
				{if $none == 1}
					<div class="paragraph"><dd><strong>{'No Events.'|gettext}</strong></dd></div>
				{/if}
				{br}
			{/if_elements}
		{/foreach}
	</dl>
</div>

{script unique="cal-`$name`" yui3mods="node"}
{literal}

EXPONENT.YUI3_CONFIG.modules = {
	'gallery-calendar': {
		fullpath: '{/literal}{$asset_path}js/calendar.js{literal}',
		requires: ['node']
	}
}

YUI(EXPONENT.YUI3_CONFIG).use('gallery-calendar',function(Y){
	var today = new Date({/literal}{$time}{literal}*1000);

	//Popup
	var cal = new Y.Calendar('J_popup_closeable',{
		popup:true,
		closeable:true,
		startDay:{/literal}{$smarty.const.DISPLAY_START_OF_WEEK}{literal},
		date:today,
		action:['click'],
//        useShim:true
	}).on('select',function(d){
		var unixtime = parseInt(d / 1000);
    {/literal} {if ($smarty.const.SEF_URLS == 1)} {literal}
        window.location=eXp.PATH_RELATIVE+'event/showall/time/'+unixtime+'/src/{/literal}{$__loc->src}{literal}';
    {/literal} {else} {literal}
        window.location=eXp.PATH_RELATIVE+'index.php?controller=event&action=showall&time='+unixtime+'&src={/literal}{$__loc->src}{literal}';
    {/literal} {/if} {literal}
	});
    Y.one('#J_popup_closeable').on('click',function(d){
        cal.show();
    });

});

{/literal}
{/script}
