<?php

##################################################
#
# Copyright (c) 2004-2013 OIC Group, Inc.
#
# This file is part of Exponent
#
# Exponent is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License as published by the Free
# Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# GPL: http://www.gnu.org/licenses/gpl.txt
#
##################################################

/**
 * Smarty plugin
 * @package Smarty-Plugins
 * @subpackage Function
 */

/**
 * Smarty {popupdatetimecontrol} function plugin
 *
 * Type:     function<br>
 * Name:     popupdatetimecontrol<br>  //FIXME the popupdatetimecontrol is broken w/o the jscalendar files
 * Purpose:  ???
 *
 * @param         $params
 * @param \Smarty $smarty
 */
function smarty_function_popupdatetimecontrol($params,&$smarty) {  //FIXME this seems like a empty copy of something else
	if (isset($params['name']) ) {
		$control = new $params['type'];
		echo $control->controlToHTML($params['name']);
	}
}

?>
