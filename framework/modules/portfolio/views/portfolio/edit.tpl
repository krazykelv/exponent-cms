{*
 * Copyright (c) 2004-2011 OIC Group, Inc.
 * Written and Designed by Adam Kessler
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

<div id="editportfolio" class="module blog edit hide exp-skin-tabview">
    
    {if $record->id != ""}<h1>Editing {$record->title}</h1>{else}<h1>New {$modelname}</h1>{/if}
    
    {form action=update}
        {control type=hidden name=id value=$record->id}
        <div id="demo" class="yui-navset">
            <ul class="yui-nav">
                <li class="selected"><a href="#tab1"><em>General</em></a></li>
                <li><a href="#tab2"><em>Tags</em></a></li>
                <li><a href="#tab3"><em>Files</em></a></li>
                <li><a href="#tab4"><em>SEO</em></a></li>
            </ul>            
            <div class="yui-content">
            <div id="tab1">
                {control type=text name=title label="Title" value=$record->title}
                {control type="checkbox" name="featured" label="Feature this Portfolio Piece?" checked=$record->featured value=1}
                {control type=html name=body label="Description" value=$record->body}
            </div>
            <div id="tab2">
                <h2>Tags</h2>
                {foreach from=$record->expTag item=tag name=tags}
                {if $smarty.foreach.tags.first == false}
                        {assign var=tags value="`$tags`,`$tag->title`"}
                    {else}
                        {assign var=tags value=$tag->title}
                    {/if}                    
                {/foreach}
                {control type="textarea" name="expTag" label="Tags (comma separated)" value=$tags}
            </div>
            <div id="tab3">
                {control type="files" name="files" label="Files" value=$record->expFile}
            </div>
            <div id="tab4">
                 <h2>SEO Settings</h2>
                {control type="text" name="sef_url" label="SEF URL" value=$record->sef_url}
                {control type="text" name="meta_title" label="Meta Title" value=$record->meta_title}
                {control type="textarea" name="meta_keywords" label="Meta Keywords" rows=5 cols=35 value=$record->meta_keywords}
                {control type="textarea" name="meta_description" label="Meta Description" rows=5 cols=35 value=$record->meta_description}
            </div>
            </div>
        </div>
        {control type=buttongroup submit="Save Text" cancel="Cancel"}
    {/form}   
    
</div>
<div class="loadingdiv">Loading Form</div>


{script unique="editform" yui3mods=1}
{literal}
    YUI(EXPONENT.YUI3_CONFIG).use('node','yui2-tabview','yui2-element', function(Y) {
        var YAHOO=Y.YUI2;

        var tabView = new YAHOO.widget.TabView('demo');
        Y.one('#editportfolio').removeClass('hide').next().remove();
    });
{/literal}
{/script}
