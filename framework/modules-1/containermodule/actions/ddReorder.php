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

if (!defined('EXPONENT')) exit('');

if (expPermissions::check('manage',$loc)) {
	
	$json2php = json_decode(stripslashes($_REQUEST['neworder']));

	foreach($json2php as $value){

		$container = $db->selectObject("container","id=".$value->container);
		$rank = 0;
		//eDebug($container);
		foreach($value->module as $mod){
			$module = $db->selectObject("container","id=".$mod);

			$module->external = $container->internal;
			$module->rank = $rank;
			$rank++;
			$db->updateObject($module,"container") or die($db->error());
		   	expSession::clearAllUsersSessionCache('containermodule');
		}
	}
} else {
	echo SITE_403_HTML;
}


exit;

?>
