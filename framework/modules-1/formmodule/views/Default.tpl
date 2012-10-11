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

{css unique="formmod" corecss="forms"}

{/css}

{if $form->style}
{css unique="formmod2" corecss="forms2col"}

{/css}
{/if}

<div class="formmodule default">
    {messagequeue name='notice'}
	{permissions}
		<div class="module-actions">
			{if $permissions.viewdata == 1 && $form->is_saved == 1}<a class="view addnew mngmntlink" href="{link action=view_data module=formbuilder id=$form->id}">{'View Data'|gettext} ({$count})</a>&#160;&#160;{/if}
			{if $permissions.viewdata == 1 && $form->is_saved == 1}|&#160;&#160;<a class="downloadfile addnew mngmntlink" href="{link action=export_csv module=formbuilder id=$form->id}">{"Export CSV"|gettext}</a>&#160;&#160;
				{if $permissions.editformsettings == 1}|&#160;&#160;
				{/if}
			{/if}
			{if $permissions.editformsettings == 1}<a class="configure addnew mngmntlink" href="{link action=edit_form module=formbuilder id=$form->id}">{'Form Settings'|gettext}</a>&#160;&#160;{/if}
			{if $permissions.editform == 1}|&#160;&#160;<a class="edit addnew mngmntlink" href="{link action=view_form module=formbuilder id=$form->id}">{'Edit Form'|gettext}</a>&#160;&#160;{/if}
			{if $permissions.editreport == 1}|&#160;&#160;<a class="edit addnew mngmntlink" href="{link action=edit_report module=formbuilder id=$form->id}">{'Edit Report'|gettext}</a>&#160;&#160;{/if}
		</div>
	{/permissions}
	{if $moduletitle && !$config.hidemoduletitle}<h1>{$moduletitle}</h1>{/if}
	 <div class="bodycopy">
    	{if $description != ""}
    		{$description}
    	{/if}
		{$form_html}
	</div>
</div>