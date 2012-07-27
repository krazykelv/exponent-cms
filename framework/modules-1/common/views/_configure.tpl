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

{if $hasConfig == 1}
{css unique="forms" corecss="forms"}

{/css}
<div class="form_header">
	<h1>{'Configure Settings for this'|gettext} {$title} {'Module'|gettext}</h1>
	<p>{'Use this form to configure the behavior of the module.'|gettext}</p>
</div>
{$form_html}
{script unique="configure" yui3mods=1}
{literal}
    YUI(EXPONENT.YUI3_CONFIG).use('tabview', function(Y) {
        var tabview = new Y.TabView({srcNode:'#configure-tabs'});
        tabview.render();
        Y.one('#configure-tabs').removeClass('hide');
        Y.one('.loadingdiv').remove();
    });
{/literal}
{/script}

{else}
{'No Configuration Data Found.  This module cannot be configured.'|gettext}
{/if}