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
 <div class="module store show event-registration">
     <h1>{$product->title}</h1>
     <div class="image">
         {if $product->expFile.mainimage[0]->url == ""}
             {img src="{$smarty.const.ICON_RELATIVE|cat:'ecom/no-image.jpg'}"}
         {else}
			 {img file_id=$product->expFile.mainimage[0]->id w=250 alt=$product->image_alt_tag|default:"Image of `$product->title`" title="`$product->title`"  class="large-img" id="enlarged-image"}
         {/if}
         {clear}
     </div>
     <div class="bd">
         {permissions}
             <div class="item-actions">
                 {if $permissions.configure == 1 or $permissions.manage == 1}
                     {icon action=edit record=$product title="Edit this entry"|gettext}
                     {icon action=delete record=$product title="Delete this entry"|gettext}
                 {/if}
             </div>
         {/permissions}
         <div class="bodycopy">{$product->body}</div>
         <span class="date">
             <span class="label">{'Event Date'|gettext}: </span><span class="value">{$product->eventdate|date_format:"%A, %B %e, %Y"}</span>{br}
             <span class="label">{'Start Time'|gettext}: </span><span class="value">{($product->eventdate+$product->event_starttime)|expdate:"g:i a"}</span>{br}
             <span class="label">{'End Time'|gettext}: </span><span class="value">{($product->eventdate+$product->event_endtime)|expdate:"g:i a"}</span>{br}
             {br}
             <span class="label">{'Seats Available:'|gettext} </span><span class="value">{$product->spacesLeft()} {'of'|gettext} {$product->quantity}</span>{br}
             <span class="label">{'Registration Closes:'|gettext} </span><span class="value">{$product->signup_cutoff|expdate:"l, F j, Y, g:i a"}</span>{br}
         </span>
         <div class="price">{currency_symbol}{$product->base_price|number_format:2}</div>
         {if $product->isAvailable()}
            <a href="{link controller=cart action=addItem product_id=$product->id product_type=$product->product_type}" class="addtocart exp-ecom-link" rel="nofollow">
                {'Add to cart'|gettext}<span></span>
            </a>
         {else}
            <a href="#" class="addtocart exp-ecom-link">
                {'Registration is closed.'|gettext}<span></span>
            </a>
         {/if}
     </div>
     {clear}
 </div>
