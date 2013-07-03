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

    {$myloc=serialize($__loc)}
    {pagelinks paginate=$page top=1}
    {foreach from=$page->records item=item}
        <div class="item">
            {if $config.datetag}
                <p class="post-date">
                    <span class="month">{$item->publish_date|format_date:"%b"}</span>
                    <span class="day">{$item->publish_date|format_date:"%e"}</span>
                    <span class="year">{$item->publish_date|format_date:"%Y"}</span>
                </p>
            {$pp = ''}
            {/if}
            <h2>
                <a href="{if $item->isRss}{$item->rss_link}{else}{link action=show title=$item->sef_url}{/if}" title="{$item->body|summarize:"html":"para"}">
                {$item->title}
                </a>
            </h2>
            {if !$config.datetag}
                <span class="date">{$item->publish_date|format_date}</span>
            {$pp = '&#160;&#160;|&#160;&#160;'}
            {/if}
            {tags_assigned record=$item prepend=$pp}
            {if $item->isRss != true}
                {permissions}
                    <div class="item-actions">
                        {if $permissions.edit == true}
                            {if $myloc != $item->location_data}
                                {if $permissions.manage == 1}
                                    {icon action=merge id=$item->id title="Merge Aggregated Content"|gettext}
                                {else}
                                    {icon img='arrow_merge.png' title="Merged Content"|gettext}
                                {/if}
                            {/if}
                            {icon action=edit record=$item}
                        {/if}
                        {if $permissions.delete == true}
                            {icon action=delete record=$item}
                        {/if}
                    </div>
                {/permissions}
            {/if}
            <div class="bodycopy">
                {if $config.ffloat != "Below"}
                    {filedisplayer view="`$config.filedisplay`" files=$item->expFile record=$item is_listing=1}
                {/if}
                {if $config.usebody==1}
                    <p>{$item->body|summarize:"html":"paralinks"}</p>
                {elseif $config.usebody==2}
				{else}
                    {$item->body}
                {/if}
                {if $config.ffloat == "Below"}
                    {filedisplayer view="`$config.filedisplay`" files=$item->expFile record=$item is_listing=1}
                {/if}
                <a class="readmore" href="{if $item->isRss}{$item->rss_link}{else}{link action=show title=$item->sef_url}{/if}">{"Read More"|gettext}</a>
            </div>
            {clear}
        </div>
    {/foreach}
    {pagelinks paginate=$page bottom=1}
