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

<div class="module donation showall">
    {if $moduletitle && !$config.hidemoduletitle}<h1>{$moduletitle}</h1>{/if}
    {permissions}
        {if $permissions.edit == 1 or $permissions.manage == 1}
            <div id="prod-admin">
                {icon class="add" controller=store action=edit id=0 product_type=donation text="Add a new donation cause"|gettext}
            </div>
        {/if}
    {/permissions}
    {if $config.moduledescription != ""}
   		{$config.moduledescription}
   	{/if}
    {assign var=myloc value=serialize($__loc)}
    <table>
    {foreach from=$causes item=cause}
        <tr>
            <td>{img file_id=$cause->expFile.mainimage[0]->id square=120}</td>
            <td>
                <h3>{$cause->title}</h3>
                {$cause->body}
            </td>
            <td>
                <a href="{link controller=cart action=addItem quick=1 product_type=$cause->product_type product_id=$cause->id}">{'Donate Now'|gettext}</a>
            </td>
            <td>
                {permissions}
					<div class="item-actions">
						{if $permissions.edit == 1}
							{icon controller=store action=edit record=$cause title="Edit Donation"|gettext}
						{/if}
						{if $permissions.delete == 1}
							{icon controller=store action=delete record=$cause title="Remove Donation"|gettext}
						{/if}
					</div>
                {/permissions}
            </td>
         </tr>
    {foreachelse}
        <h2>{"No causes have been setup for donations."|gettext}</h2>
    {/foreach}
    </table>
</div>
