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

if (expPermissions::check('database',expCore::makeLocation('administrationmodule'))) {
	$exporters = array();
	$idh = opendir(BASE.'framework/modules-1/exporter/exporters');
	while (($imp = readdir($idh)) !== false) {
		if (substr($imp,0,1) != '.' && is_readable(BASE.'framework/modules-1/exporter/exporters/'.$imp.'/start.php') && is_readable(BASE.'framework/modules-1/exporter/exporters/'.$imp.'/info.php')) {
			$exporters[$imp] = include(BASE.'framework/modules-1/exporter/exporters/'.$imp.'/info.php');
		}
	}
	
	$template = new template('exporter','_exporters');
	$template->assign('exporters',$exporters);
	$template->output();
	
} else {
	echo SITE_403_HTML;
}

?>