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

<div class="module text edit yui-skin-sam">
    {if $record->id != ""}
        <h1>{'Editing'|gettext} {$record->title}</h1>
    {else}
        <h1>{'New Countdown'|gettext}</h1>
    {/if}

    {form action=update}
        {control type=hidden name=id value=$record->id}
        {control type=text name=title label="Title"|gettext value=$record->title}
        {control type=textarea cols="80" rows=20 name=body label="Countdown Snippet"|gettext value=$record->body}
        {control type=buttongroup submit="Save Text"|gettext cancel="Cancel"|gettext}
    {/form}   
</div>
