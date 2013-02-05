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

{css unique="manageorderstatus" corecss="tables"}

{/css}

<div class="modules order_status showall">
	<h1>{$moduletitle|default:"Manage Status Codes"|gettext}</h1>
    {permissions}
        <div class="module-actions">
            {if $permissions.create == 1}
                {icon class=add action=create text="Create a new status code"|gettext}
            {/if}
            {if $permissions.manage == 1}
                {ddrerank items=$page->records model="order_status" label="Order Statuses"|gettext}
            {/if}
        </div>
    {/permissions}
	<div id="orders">
		{pagelinks paginate=$page top=1}
		<table id="prods" class="exp-skin-table">
			<thead>
				<tr>
				    <th>{'Default'|gettext}</th>
				    <th>{'Treat as Closed'|gettext}</th>
					<th>{'Name'|gettext}</th>
					<th>{'Action'|gettext}</th>
				</tr>
			</thead>
			<tbody>
				{foreach from=$page->records item=listing name=listings}
                    <tr class="{cycle values="odd,even"}">
                        <td>
                            {if $listing->is_default == 1}
                                <a href="{link action=toggle_default id=$listing->id}">{icon img="toggle_on.png"}</a>
                            {else}
                                <a href="{link action=toggle_default id=$listing->id}">{icon img="toggle_off.png"}</a>
                            {/if}
                        <td>
                            {if $listing->treat_as_closed == 1}
                                <a href="{link action=toggle_closed id=$listing->id}">{icon img="toggle_on.png"}</a>
                            {else}
                                <a href="{link action=toggle_closed id=$listing->id}">{icon img="toggle_off.png"}</a>
                            {/if}
                        </td>
                        <td>{$listing->title}</td>
                        <td>
                            {if $permissions.manage == true}
                                {icon controller=order_status action=edit record=$listing}
                                {icon controller=order_status action=delete record=$listing}
                            {/if}
                        </td>
                    </tr>
				{foreachelse}
				    <tr class="{cycle values="odd,even"}">
				        <td colspan="4">{'No order status codes have been created yet.'|gettext}</td>
				    </tr>
				{/foreach}
            </tbody>
		</table>
		{pagelinks paginate=$page bottom=1}
	</div>
</div>
