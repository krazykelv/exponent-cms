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

{css unique="edit-report" corecss="forms"}

{/css}

<div class="module formbuilder edit-report">
	<div class="form_title">
		<h1>{'Report Editor'|gettext}</h1>
	</div>
	{$form_html}
{script unique="configure" yui3mods=1}
{literal}
    EXPONENT.YUI3_CONFIG.modules.exptabs = {
        fullpath: EXPONENT.JS_RELATIVE+'exp-tabs.js',
        requires: ['history','tabview','event-custom']
    };

    YUI(EXPONENT.YUI3_CONFIG).use('exptabs', function(Y) {
        Y.expTabs({srcNode: '#configure-tabs'});
        Y.one('#configure-tabs').removeClass('hide');
        Y.one('.loadingdiv').remove();
    });
{/literal}
{/script}
</div>

