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
 * Smarty {get_favorites} function plugin
 *
 * Type:     function<br>
 * Name:     get_favorites<br>
 * Purpose:  get and assign favorites
 *
 * @param         $params
 * @param \Smarty $smarty
 */
function smarty_function_get_favorites($params,&$smarty) {

	global $user;
	$uid = empty($params['user_id']) ? $user->id : $params['user_id'];
	$id = empty($params['id']) ? null : $params['id'];
	$smarty->assign($params['assign'],favorites::get($params['module'],$id,$uid));
}

?>
