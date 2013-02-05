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
{css unique="event-listings" link="`$asset_path`css/storefront.css" corecss="button,tables"}

{/css}

{css unique="event-listings1" link="`$asset_path`css/eventregistration.css"}

{/css}

<div class="module events showall headlines">
    {if $moduletitle && !($config.hidemoduletitle xor $smarty.const.INVERT_HIDE_TITLE)}<h2>{$moduletitle}</h2>{/if}
    {permissions}
        <div class="module-actions">
            {if $permissions.create == true || $permissions.edit == true}
                {icon class="add" controller=store action=edit product_type=eventregistration text="Add an event"|gettext}
            {/if}
            {if $permissions.manage == 1}
                 {icon action=manage text="Manage Events"|gettext}
            {/if}
        </div>
    {/permissions}
    {if $config.moduledescription != ""}
   		{$config.moduledescription}
   	{/if}
    {$myloc=serialize($__loc)}
    <ul>
        {foreach name=items from=$page->records item=item}
            {if $smarty.foreach.items.iteration<=$config.headcount || !$config.headcount}
                <li>
                    <div class="events">
                        <a class="link" href="{link action=show title=$item->sef_url}" title="{'Register for this Event'|gettext}">{$item->title}</a>
                        <a href="{link action=show title=$item->sef_url}"></a>
                        - <em class="date">{$item->eventdate|date_format}</em>
                        - {$item->body|summarize:"text":"para"}
                        {if $item->base_price}- {'Cost'|gettext}: {currency_symbol}{$item->base_price}{/if}
                        {if $item->isRss != true}
                            {permissions}
                                <div class="item-actions">
                                    {if $permissions.edit == true}
                                        {icon controller="store" action=edit record=$item}
                                    {/if}
                                    {if $permissions.delete == true}
                                        {icon controller="store" action=delete record=$item}
                                    {/if}
                                </div>
                            {/permissions}
                        {/if}
                    </div>
                </li>
            {/if}
        {/foreach}
    </ul>
</div>