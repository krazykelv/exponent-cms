<?php

##################################################
#
# Copyright (c) 2004-2011 OIC Group, Inc.
# Written and Designed by James Hunt
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

$iloc = exponent_core_makeLocation($_GET['m'],@$_GET['s'],@$_GET['i']);

// Make sure that locref refcount is indeed 0.
//$locref = $db->selectObject("locationref","module='".$iloc->mod."' AND source='".$iloc->src."' AND internal='".$iloc->int."'");
//if ($locref && $locref->refcount == 0 && exponent_permissions_check("administrate",$iloc)) {
$secref = $db->selectObject("sectionref","module='".$iloc->mod."' AND source='".$iloc->src."' AND internal='".$iloc->int."'");
if ($secref && $secref->refcount == 0 && exponent_permissions_check("administrate",$iloc)) {
	// delete in location.
	$modclass = $iloc->mod;
    expSession::clearAllUsersSessionCache('containermodule');
    expSession::clearAllUsersSessionCache($iloc);
	
	//FIXME: more module/controller glue code
	if (controllerExists($modclass)) {
	    $mod = new $modclass($iloc->src);
	    $mod->delete_instance();
	} else {
	    $mod = new $modclass();
	    $mod->deleteIn($iloc);	    
	}
	
//	$db->delete("locationref","module='".$iloc->mod."' AND source='".$iloc->src."' AND internal='".$iloc->int."'");
	$db->delete("sectionref","module='".$iloc->mod."' AND source='".$iloc->src."' AND internal='".$iloc->int."'");
	exponent_permissions_revokeComplete($iloc);
}

expHistory::back();

?>