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

{css unique="event-show" link="`$asset_path`css/storefront.css" corecss="button,tables"}

{/css}

{css unique="event-show1" link="`$asset_path`css/eventregistration.css"}

{/css}

<div class="module store show event-registration">
    <div class="image" style="padding:0px 10px 10px;float:left;overflow: hidden;">
    {if $product->expFile.mainimage[0]->url == ""}
        {img src="`$asset_path`images/no-image.jpg"}
        {else}
        {img file_id=$product->expFile.mainimage[0]->id alt=$product->image_alt_tag|default:"Image of `$product->title`" title="`$product->title`" class="large-img" id="enlarged-image"}
    {/if}
        {clear}
    </div>

    <div class="bd">
        <h2>{$product->eventdate|date_format:"%A, %B %e, %Y"}</h2>
        <hr>
        <h3>{$product->title}</h3>
        {permissions}
            <div class="item-actions">
                {if $permissions.configure == 1 or $permissions.manage == 1}
                    {icon controller="store" action="edit" id=$product->id title="Edit this entry"|gettext}
                    {icon controller="store" action="delete" id=$product->id title="Delete this entry"|gettext}
                {/if}
            </div>
        {/permissions}
        <h4>{($product->eventdate+$product->event_starttime)|expdate:"g:i a"}
            - {($product->eventdate+$product->event_endtime)|expdate:"g:i a"}</h4>
    {time_duration start=$product->eventdate+$product->event_starttime end=$product->eventdate+$product->event_endtime assign=dur}
        ({if !empty($dur.h)}{$dur.h} {'hour'|gettext|plural:$dur.h}{/if}{if !empty($dur.h) && !empty($dur.m)} {/if}{if !empty($dur.m)}{$dur.m} {'minute'|gettext|plural:$dur.m}{/if}
        ){br}{br}
        <div class="bodycopy">
        {if $product->summary}
                {$product->summary}
            {/if}
        </div>
    {clear}

        <div id="eventregform">
        {form id="addtocart`$product->id`" controller=cart action=addItem}
            {control type="hidden" name="product_id" value="`$product->id`"}
            {control type="hidden" name="base_price" value="`$product->base_price`"}
            {control type="hidden" name="product_type" value="`$product->product_type`"}
            {*{control type="hidden" name="quick" value="1"}*}
            {if $product->spacesLeft() && $product->signup_cutoff >= time()}
                <span class="label">{'Seats Available:'|gettext} </span><span
                    class="value">{$product->spacesLeft()} {'of'|gettext} {$product->quantity}</span>{br}
                <div class="seatsContainer">
                    <div class="seatStatus">
                        {$seats = implode(',',range(1,$product->spacesLeft()))}
                            {control type=dropdown name=qtyr label="Select number of seats"|gettext items=$seats}
                    </div>
                    <div class="seatAmount">
                        {if $product->base_price}
                            <span class="seatCost">{currency_symbol}{$product->base_price}</span>{br}{'per seat'|gettext}
                            {else}
                            <span class="seatCost">{'No Cost'|gettext}</span>
                        {/if}
                    </div>
                </div>
                <span class="label">{'Registration Closes:'|gettext} </span>
                <span class="value">{$product->signup_cutoff|expdate:"l, F j, Y, g:i a"}</span>{br}{br}
                {if $product->hasOptions()}
                    <div class="product-options">
                        {control type="hidden" name="ticket_types" value="1"}
                        {foreach from=$product->optiongroup item=og}
                            {if $og->hasEnabledOptions()}
                                <div class="option {cycle values="odd,even"}">
                                    {if $og->allow_multiple}
                                        {optiondisplayer product=$product options=$og->title view=checkboxes_with_quantity display_price_as=total selected=$params.options}
                                    {else}
                                        {optiondisplayer product=$product options=$og->title view=dropdown display_price_as=total selected=$params.options}
                                    {/if}
                                </div>
                            {/if}
                        {/foreach}
                    </div>
                {/if}

                {foreach from=$product->expDefinableField.registrant item=fields}
                    {$product->getControl($fields)}
                {/foreach}

                <h2>{'Who\'s Coming?'|gettext}</h2>
                {'Please provide the names of the people who will be attending this event'|gettext},
                <strong>{'including yourself, if you are attending'|gettext}</strong>.
                {'You don\'t have to provide the phone and email address, but it makes it easier to get in touch with those attending.'|gettext}
                <table class="exp-skin-table" id="reg" border="0" cellpadding="3" cellspacing="0">
                    <thead>
                        <th>
                            <span>&#160;</span>
                        </th>
                        <th>
                            <span>{'Name'|gettext}</span>
                            <span style="color:Red;">*</span>
                        </th>
                        <th>
                            <span>{'Phone'|gettext}</span>
                        </th>
                        <th>
                            <span>{'Email'|gettext}</span>
                        </th>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <span>{'Seat'|gettext} 1</span>
                            </td>
                            <td>
                                <input name="event[0][name]" type="text" required=1/>
                            </td>
                            <td>
                                <input name="event[0][phone]" type="text" />
                            </td>
                            <td>
                                <input name="event[0][email]" type="text" />
                            </td>
                        </tr>
                    </tbody>
                </table>

                {if $product->require_terms_and_condition}
                    <div class="terms_and_conditions">
                        {if $product->terms_and_condition_toggle}
                            {control type=checkbox name=terms_and_condition value=1 label="I Agree To The Following <a class='toggle' href='javascript:;'>Waiver</a>" required=1}
                            <div class="more-text" style="height: 0px;">
                                {$product->terms_and_condition}
                            </div>
                            {else}
                            {control type=checkbox name=terms_and_condition value=1 label="I Agree To The Following Waiver"|gettext required=1}
                            <div class="more-text" style="height: auto;">
                                {$product->terms_and_condition}
                            </div>
                        {/if}
                    </div>
                    {else}
                    <div class="more-text" style="height: 0px;"></div>
                {/if}

                <button type="submit" class="awesome {$smarty.const.BTN_COLOR} {$smarty.const.BTN_SIZE}"
                        style="margin: 20px auto; display: block;" rel="nofollow">
                    {"Register Now"|gettext}
                </button>
            {else}
                {if $product->spacesLeft()}
                    <span class="label">{'Seats Available:'|gettext} </span><span
                        class="value"> {'None'|gettext}</span>{br}
                {/if}
                <span class="label">{'Registration is Closed!'|gettext}</span>
            {/if}
        {/form}
        </div>
    </div>
{clear}
</div>

{script unique="expanding-text" yui3mods="yui"}
{literal}
    YUI().use("anim-easing","node","anim","io", function(Y) {
        // This is for the terms and condition toogle
        var content = Y.one('.more-text').plug(Y.Plugin.NodeFX, {
            to: { height: 0 },
            from: {
            height: function(node) { // dynamic in case of change
                return node.get('scrollHeight'); // get expanded height (offsetHeight may be zero)
            }
        },

        easing: Y.Easing.easeOut,
        duration: 0.5
    });

        var onClick = function(e) {
            e.halt();
            //e.toggleClass('yui-closed');
            Y.one('.event-registration .bodycopy').toggleClass('yui-closed');
            content.fx.set('reverse', !content.fx.get('reverse')); // toggle reverse
            content.fx.run();
        };

        var control = Y.one('.toggle');

        if(control != null) {
            control.on('click', onClick);
        }
        // End of script for terms and condition toogle

        function addRow(tableID) {
            var table = document.getElementById(tableID);
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);
            var cell1 = row.insertCell(0);
            cell1.innerHTML = "{/literal}{'Seat'|gettext}{literal} " + rowCount;

            var cell2 = row.insertCell(1);
            var element2 = document.createElement("input");
            element2.type = "text";
            element2.name = "event["+(rowCount-1)+"][name]";
            element2.required = true;
            cell2.appendChild(element2);

            var cell3 = row.insertCell(2);
            var element3 = document.createElement("input");
            element3.type = "text";
            element3.name = "event["+(rowCount-1)+"][phone]";
            cell3.appendChild(element3);

            var cell4 = row.insertCell(3);
            var element4 = document.createElement("input");
            element4.type = "text";
            element4.name = "event["+(rowCount-1)+"][email]";
            cell4.appendChild(element4);
        }

        function deleteRow(tableID) {
            try {
                var table = document.getElementById(tableID);
                table.deleteRow(table.rows.length - 1);
            } catch (e) {
                alert(e);
            }
        }

        Y.one('#qtyr').on('change', function(e) {
            var numAsked = e.target.get('value') * 1; // because it is a string and I want a number
            var table = document.getElementById('reg');
            var change = numAsked - table.rows.length + 1;
            if (change == 0) {
                return;
            }
            if (change < 0) {
                // remove extra lines
                for (var i=change; i<=-1; i++) {
                    deleteRow('reg')
                }
                return;
            }
            if (change > 0) {
                // build new lines
                for (var i=1; i<=change; i++) {
                    addRow('reg');
                }
                return;
            }
        });
    });
{/literal}
{/script}