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

{css unique="blog" link="`$asset_path`../../blog/assets/css/blog.css"}

{/css}

<div class="module blog showall">
    {if $moduletitle && !$config.hidemoduletitle}<h1>{$moduletitle}</h1>{/if}
    
    {permissions}
		<div class="module-actions">
			{if $permissions.configure == 1}
				{icon class=configure action=configure text="Configure Service"|gettext}
			{/if}

		</div>
    {/permissions}
    <h2>{'API Key'|gettext}</h2>
    <textarea style="width:100%; height:200px;">{$info.apikey}</textarea>
    {*edebug var=$info*}

</div>
