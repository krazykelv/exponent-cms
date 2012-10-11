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

<div class="module news show">
    {if $config.datetag}
        <p class="post-date">
            <span class="month">{$record->publish_date|format_date:"%b"}</span>
            <span class="day">{$record->publish_date|format_date:"%e"}</span>
            <span class="year">{$record->publish_date|format_date:"%Y"}</span>
        </p>
    {/if}
    <h1>{$record->title}</h1>
    {printer_friendly_link}{export_pdf_link prepend='&#160;&#160;|&#160;&#160;'}{br}
    {subscribe_link}
    {assign var=myloc value=serialize($__loc)}
    {if !$config.datetag}
        <span class="date">{$record->publish_date|format_date:"%A, %B %e, %Y"}</span>
    {/if}
    {if $record->expTag|@count>0 && !$config.disabletags}
        <div class="tags">
            {"Tags"|gettext}:
            {foreach from=$record->expTag item=tag name=tags}
                <a href="{link action=showall_by_tags tag=$tag->sef_url}">{$tag->title}</a>{if $smarty.foreach.tags.last != 1},{/if}
            {/foreach}
        </div>
    {/if}
    {permissions}
        <div class="item-actions">   
            {if $permissions.edit == true}
                {if $myloc != $record->location_data}
                    {if $permissions.manage == 1}
                        {icon action=merge id=$record->id title="Merge Aggregated Content"|gettext}
                    {else}
                        {icon img='arrow_merge.png' title="Merged Content"|gettext}
                    {/if}
                {/if}
                {icon action=edit record=$record}
            {/if}
            {if $permissions.delete == true}
                {icon action=delete record=$record}
            {/if}
        </div>
    {/permissions}
    <div class="bodycopy">
        {if $config.filedisplay != "Downloadable Files"}
            {filedisplayer view="`$config.filedisplay`" files=$record->expFile record=$record}
        {/if}
        {$record->body}
        {if $config.filedisplay == "Downloadable Files"}
            {filedisplayer view="`$config.filedisplay`" files=$record->expFile record=$record}
        {/if}
    </div>
    {if $record->prev || $record->next}
        <div class="module-actions">
            {clear}
            <hr>
            <span style="float:left">
                {if $record->prev}
                    <a href="{link action=show title=$record->prev->sef_url}" title="{$record->prev->body|summarize:"html":"para"}">
                        {icon img='page_prev.png' title='Previous Item'|gettext}
                        {$record->prev->title}
                    </a>
                {/if}
            </span>
            <span style="float:right">
                {if $record->next}
                    <a href="{link action=show title=$record->next->sef_url}" title="{$record->next->body|summarize:"html":"para"}">
                        {$record->next->title}
                        {icon img='page_next.png' title='Next Item'|gettext}
                    </a>
                {/if}
            </span>
            {clear}
            <hr>
        </div>
    {/if}
</div>
