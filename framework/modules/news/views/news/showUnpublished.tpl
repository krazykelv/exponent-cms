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

{css unique="showunpublished" corecss="tables"}

{/css}

<div class="module news show-expired">
    {if !($config.hidemoduletitle xor $smarty.const.INVERT_HIDE_TITLE)}<h1>{$moduletitle} - {"Expired and Unpublished News"|gettext}</h1>{/if}
    {pagelinks paginate=$page top=1}
    {$myloc=serialize($__loc)}
	<table id="prods" class="exp-skin-table" width="95%">
	    <thead>
		<tr>
		    {$page->header_columns}
			<th>{'Actions'|gettext}</th>
		</tr>
		</thead>
		<tbody>
			{foreach from=$page->records item=listing name=listings}
			<tr class="{cycle values="odd,even"}">
				<td><a href="{link controller=news action=show id=$listing->id}" title="{$listing->body|summarize:"html":"para"}">{$listing->title}</a></td>
				<td>{$listing->publish_date|format_date:"%B %e, %Y"}</td>
				<td>
				    {if $listing->unpublish == 0}
				        {'Unpublished'|gettext}
				    {else}
				        {'Expired'|gettext} - {$listing->unpublish|format_date:"%B %e, %Y"}
				    {/if}
				</td>
				<td>
				    {permissions}
						<div class="item-actions">
							{if $permissions.edit || ($permissions.create && $listing->poster == $user->id)}
                                {if $myloc != $listing->location_data}
                                    {if $permissions.manage}
                                        {icon action=merge id=$listing->id title="Merge Aggregated Content"|gettext}
                                    {else}
                                        {icon img='arrow_merge.png' title="Merged Content"|gettext}
                                    {/if}
                                {/if}
								{icon action=edit record=$listing}
							{/if}
							{if $permissions.delete || ($permissions.create && $listing->poster == $user->id)}
								{icon action=delete record=$listing}
							{/if}
						</div>
                    {/permissions}
				</td>
			</tr>
			{foreachelse}
			    <td colspan=3>{'There is no expired news'|gettext}.</td>
			{/foreach}
		</tbody>
	</table>
    {pagelinks paginate=$page bottom=1}
</div>
