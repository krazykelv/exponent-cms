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

<div id="fedex">
    <div id="fedex-tabs" class="yui-navset exp-skin-tabview hide">
        <ul class="yui-nav">
	        <li class="selected"><a href="#tab1"><em>{'FedEx Settings'|gettext}</em></a></li>
	        <li><a href="#tab2"><em>{'Shipping Methods'|gettext}</em></a></li>
	        <li><a href="#tab3"><em>{'My Info'|gettext}</em></a></li>
	        <li><a href="#tab4"><em>{'Shipping Defaults'|gettext}</em></a></li>
        </ul>
        <div class="yui-content">
	        <div id="tab1">
	            {control type="text" name="fedex_account_number" label="FedEx Account Number"|gettext value=$calculator->configdata.fedex_account_number}
	            {control type="text" name="fedex_meter_number" label="Meter Number"|gettext value=$calculator->configdata.fedex_meter_number}
	            {control type="text" name="fedex_key" label="Key"|gettext value=$calculator->configdata.fedex_key}
	            {control type="text" name="fedex_password" label="Password"|gettext value=$calculator->configdata.fedex_password}
	            {*control type="text" name="shipfrom[shipperNumber]" label="Account #" value=$calculator->configdata.shipfrom.shipperNumber*}
	            {control type="checkbox" name="testmode" label="Enable Test Mode"|gettext value=1 checked=$calculator->configdata.testmode}
	        </div>
	        <div id="tab2">
	            {control type="checkbox" name="shipping_methods[]" label="FedEx Next Day Air - Delivery by 8:30AM"|gettext value="FIRST_OVERNIGHT" checked=$calculator->configdata.shipping_methods}
	            {control type="checkbox" name="shipping_methods[]" label="FedEx Next Day Air - Delivery by 10:30AM"|gettext value="PRIORITY_OVERNIGHT" checked=$calculator->configdata.shipping_methods}
	            {control type="checkbox" name="shipping_methods[]" label="FedEx Standard Overnight - Delivery by 3PM"|gettext value="STANDARD_OVERNIGHT" checked=$calculator->configdata.shipping_methods}
	            {control type="checkbox" name="shipping_methods[]" label="FedEx 2Day - Delivery by 10:30AM" value="FEDEX_2_DAY_AM"|gettext checked=$calculator->configdata.shipping_methods}
	            {control type="checkbox" name="shipping_methods[]" label="FedEx 2Day - Delivery by 4:30PM" value="FEDEX_2_DAY"|gettext checked=$calculator->configdata.shipping_methods}
	            {control type="checkbox" name="shipping_methods[]" label="FedEx 3Day Express Saver - Delivery by 4:30PM"|gettext value="FEDEX_EXPRESS_SAVER" checked=$calculator->configdata.shipping_methods}
	            {control type="checkbox" name="shipping_methods[]" label="FedEx Ground - 1-5 Business Days"|gettext value="FEDEX_GROUND" checked=$calculator->configdata.shipping_methods}
	        </div>
	        <div id="tab3">
	            {*control type="text" name="shipfrom[name]" label="Company Name" value=$calculator->configdata.shipfrom.name}
	            {control type="text" name="shipfrom[phone]" label="Phone Number" value=$calculator->configdata.shipfrom.phone*}
	            {control type="text" name="shipfrom[address1]" label="Address"|gettext value=$calculator->configdata.shipfrom.address1}
	            {control type="text" name="shipfrom[address2]" label=" " value=$calculator->configdata.shipfrom.address2}
	            {control type="text" name="shipfrom[address3]" label=" " value=$calculator->configdata.shipfrom.address3}
	            {control type="text" name="shipfrom[City]" label="City"|gettext value=$calculator->configdata.shipfrom.City}
	            {control type="text" name="shipfrom[StateOrProvinceCode]" label="2 Character State Code"|gettext size=2 value=$calculator->configdata.shipfrom.StateOrProvinceCode}
	            {control type="text" name="shipfrom[PostalCode]" label="Zip Code"|gettext size=10 value=$calculator->configdata.shipfrom.PostalCode}
	            {control type="text" name="shipfrom[CountryCode]" label="2 Character Country Code"|gettext size=2 value=$calculator->configdata.shipfrom.CountryCode}
	        </div>
	        <div id="tab4">
	            {control type="text" name="default_width" label="Standard Box Width (inches)"|gettext size=5 value=$calculator->configdata.default_width}
	            {control type="text" name="default_length" label="Standard Box Length (inches)"|gettext size=5 value=$calculator->configdata.default_length}
	            {control type="text" name="default_height" label="Standard Box Height (inches)"|gettext size=5 value=$calculator->configdata.default_height}
	            {control type="text" name="default_max_weight" label="Default Weight for Box (lbs)"|gettext size=5 value=$calculator->configdata.default_max_weight}
	        </div>
        </div>
    </div>
</div>
<div class="loadingdiv">{'Loading'|gettext}</div>

{script unique="editform" yui3mods=1}
{literal}
    EXPONENT.YUI3_CONFIG.modules.exptabs = {
        fullpath: EXPONENT.JS_RELATIVE+'exp-tabs.js',
        requires: ['history','tabview','event-custom']
    };

	YUI(EXPONENT.YUI3_CONFIG).use('exptabs', function(Y) {
//		var tabview = new Y.TabView({srcNode:'#fedex-tabs'});
//		tabview.render();
        Y.expTabs({srcNode: '#fedex-tabs'});
		Y.one('#fedex-tabs').removeClass('hide');
		Y.one('.loadingdiv').remove();
    });
{/literal}
{/script}
