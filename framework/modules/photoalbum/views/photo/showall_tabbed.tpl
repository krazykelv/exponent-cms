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

{uniqueid prepend="gallery" assign="id"}

{css unique="photo-album" link="`$asset_path`css/photoalbum.css"}

{/css}

{$rel}
<div class="module photoalbum showall showall-tabbed">
    {if $moduletitle && !($config.hidemoduletitle xor $smarty.const.INVERT_HIDE_TITLE)}<h1>{/if}
    {if $moduletitle && !($config.hidemoduletitle xor $smarty.const.INVERT_HIDE_TITLE)}{$moduletitle}</h1>{/if}
    {permissions}
        <div class="module-actions">
			{if $permissions.create}
				{icon class=add action=edit rank=1 title="Add to the Top"|gettext text="Add Image"|gettext}
                {icon class=add action=multi_add title="Quickly Add Many Images"|gettext text="Add Multiple Images"|gettext}
			{/if}
            {if $permissions.manage}
                {if !$config.disabletags}
                    {icon controller=expTag class="manage" action=manage_module model='photo' text="Manage Tags"|gettext}
                {/if}
                {if $config.usecategories}
                    {icon controller=expCat action=manage model='photo' text="Manage Categories"|gettext}
                {/if}
                {if $config.order == 'rank'}
                    {ddrerank items=$page->records model="photo" label="Images"|gettext}
                {/if}
            {/if}
        </div>
    {/permissions}
    {if $config.moduledescription != ""}
   		{$config.moduledescription}
   	{/if}
    {$myloc=serialize($__loc)}
    {$quality=$config.quality|default:$smarty.const.THUMB_QUALITY}
    <div id="photos-{$id}" class="yui-navset exp-skin-tabview">
        <ul class="yui-nav">
            {foreach name=tabs from=$page->cats key=catid item=cat}
                <li><a href="#tab{$smarty.foreach.tabs.iteration}">{$cat->name}</a></li>
            {/foreach}
        </ul>
        <div class="yui-content">
            {foreach name=items from=$page->cats key=catid item=cat}
                <div id="tab{$smarty.foreach.items.iteration}">
                    <ul class="image-list">
                        {foreach from=$cat->records item=record}
                            <li style="width:{$config.pa_showall_thumbbox|default:"150"}px;height:{$config.pa_showall_thumbbox|default:"150"}px;">
                                {if $config.lightbox}
                                    {if $record->expCat[0]->title!= ""}
                                        {$group = $record->expCat[0]->title}
                                    {elseif $config.uncat!=''}
                                        {$group = $config.uncat}
                                    {else}
                                        {$group = 'Uncategorized'|gettext}
                                    {/if}
                                    {if $record->expFile[0]->image_width >= $record->expFile[0]->image_height}{$x="w"}{else}{$x="w"}{/if}
                                    <a rel="lightbox[{$name}-{$group}]" href="{$smarty.const.PATH_RELATIVE}thumb.php?id={$record->expFile[0]->id}&{$x}={$config.pa_showall_enlarged}" title="{$record->alt|default:$record->title}">
                                {else}
                                    <a href="{link action=show title=$record->sef_url}" title="{$record->alt|default:$record->title}">
                                {/if}
                                    {img class="img-small" alt=$record->alt|default:$record->expFile[0]->alt file_id=$record->expFile[0]->id w=$config.pa_showall_thumbbox|default:"150" h=$config.pa_showall_thumbbox|default:"150" far=TL f=jpeg q=$quality|default:75}
                                </a>
                                {permissions}
                                    <div class="item-actions">
                                        {if $permissions.edit || ($permissions.create && $record->poster == $user->id)}
                                            {if $myloc != $record->location_data}
                                                {if $permissions.manage}
                                                    {icon action=merge id=$record->id title="Merge Aggregated Content"|gettext}
                                                {else}
                                                    {icon img='arrow_merge.png' title="Merged Content"|gettext}
                                                {/if}
                                            {/if}
                                            {icon action=edit record=$record title="Edit"|gettext|cat:" `$modelname`"}
                                        {/if}
                                        {if $permissions.delete || ($permissions.create && $record->poster == $user->id)}
                                            {icon action=delete record=$record title="Delete"|gettext|cat:" `$modelname`"}
                                        {/if}
                                        {if $permissions.create}
                                            {icon class=add action=edit rank=$record->rank+1 title="Add another here"|gettext  text="Add After"|gettext}
                                        {/if}
                                    </div>
                                {/permissions}
                    `       </li>
                        {/foreach}
                    </ul>
                </div>
            {/foreach}
        </div>
    </div>
    <div class="loadingdiv">{'Loading'|gettext}</div>
</div>

{script unique="`$id`" yui3mods="1"}
{literal}
//    EXPONENT.YUI3_CONFIG.modules.exptabs = {
//        fullpath: EXPONENT.JS_RELATIVE+'exp-tabs.js',
//        requires: ['history','tabview','event-custom']
//    };

    EXPONENT.YUI3_CONFIG.modules = {
       'gallery-lightbox' : {
           fullpath: EXPONENT.PATH_RELATIVE+'framework/modules/common/assets/js/gallery-lightbox.js',
           requires : ['base','node','anim','selector-css3','lightbox-css']
       },
       'lightbox-css': {
           fullpath: EXPONENT.PATH_RELATIVE+'framework/modules/common/assets/css/gallery-lightbox.css',
           type: 'css'
       }
    }

	YUI(EXPONENT.YUI3_CONFIG).use('exptabs','gallery-lightbox', function(Y) {
//        Y.expTabs({srcNode: '#{/literal}{$id}{literal}'});
//		Y.one('#{/literal}{$id}{literal}').removeClass('hide');
//		Y.one('.loadingdiv').remove();
        Y.Lightbox.init();
	});
{/literal}
{/script}

{script unique="photos-`$id`" jquery="jqueryui"}
{literal}
    $('#photos-{/literal}{$id}{literal}').tabs().next().remove();
{/literal}
{/script}
