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

<div class="module flowplayer edit">
    <h1>
        {if $record->id}{'New Video'|gettext}{else}{'Editing'|gettext} {$record->title}{/if}
    </h1>

	{if !$config.video_width}
		{*{assign var="width" value="200"}*}
        {$width="200"}
	{else}
		{*{assign var="width" value=$config.video_width}*}
        {$width=$config.video_width}
	{/if}
	{if !$config.video_height}
		{*{assign var="height" value="143"}*}
        {$height="143"}
	{else}
		{*{assign var="height" value=$config.video_height}*}
        {$height=$config.video_height}
	{/if}
    {form action=update}
        {control type="hidden" name="id" value=$record->id}
        {control type="hidden" name=rank value=$record->rank}
        {control type="text" name="title" label="Video Title"|gettext value=$record->title}
        {control type="html" name="body" label="Video Description"|gettext value=$record->body}
        {control type="text" name="width" label="Width"|gettext filter=integer value=$record->width|default:$width}
        {control type="text" name="height" label="Height"|gettext filter=integer value=$record->height|default:$height}
        {control type="files" name="files" label="Media File"|gettext|cat:" (.flv, .f4v, or .mp3)" subtype=video value=$record->expFile limit=1}
        {control type="files" name="splash" label="Splash Image"|gettext subtype=splash value=$record->expFile limit=1}
        {control type="buttongroup" submit="Submit"|gettext cancel="Cancel"|gettext}
    {/form}
</div>
