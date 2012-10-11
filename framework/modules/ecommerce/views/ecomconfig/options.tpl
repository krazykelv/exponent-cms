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

{permissions}
{if $permissions.manage == 1}

<div class="module storeadmin options">
	<h1>{$moduletitle|default:"Manage Product Options"|gettext}</h1>
	
	<a class="add" href="{link action=edit_optiongroup_master}">{'Create new option group'|gettext}</a>
	{foreach from=$optiongroups item=group}
    <table style="border:1px solid red;">
    <thead><th>
	    <h2>
	        {$group->title} 
	        {icon img='edit.png' action=edit_optiongroup_master record=$group}
	        {icon img='delete.png' action=delete_optiongroup_master record=$group onclick="return confirm('This option group is being used by `$group->timesImplemented` products. Deleting this option group will also delete all of the options related to it. Are you sure you want to delete this option group?');"}
	    </h2>
	</th></thead>  
    <tbody>
    <tr><td>
	    <a href="{link action=edit_option_master optiongroup_master_id=$group->id}">{'Add an option to'|gettext} {$group->title}</a>
	    <ul>
	        {foreach name=options from=$group->option_master item=optname}
	            <li>
	                ({$optname->id}) {$optname->title}({$optname->rank}) 
	                {icon img='edit.png' action=edit_option_master record=$optname}
                    {if $optname->timesImplemented > 0}
	                    {icon img='delete.png' action=delete_option_master record=$optname onclick="alert('This option is being used by `$optname->timesImplemented` products. You may not delete this option until they are removed from the products.'); return false;"}
                    {else}
                        {icon img='delete.png' action=delete_option_master record=$optname onclick="return true;"}
                    {/if}
                    {if $smarty.foreach.options.first == 0}
                        {icon controller=ecomconfig action=rerank_optionmaster img='up.png' record=$optname push=up master_id=$optname->optiongroup_master_id}
                    {/if}
                    {if $smarty.foreach.options.last == 0}
                        {icon controller=ecomconfig action=rerank_optionmaster img='down.png' record=$optname push=down master_id=$optname->optiongroup_master_id}
                    {/if}
	            </li>
	        {foreachelse}
	            {'This option group doesn\'t have any options yet.'|gettext}
	        {/foreach}
	    </ul>
    </td></tr>
    </tbody>  
    </table>
	{foreachelse}
	    <h2>{'There are no product options setup yet.'|gettext}</h2>
	{/foreach}
</div>
{/if}
{/permissions}
