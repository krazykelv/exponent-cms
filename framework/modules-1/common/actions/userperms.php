<?php

##################################################
#
# Copyright (c) 2004-2012 OIC Group, Inc.
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
/** @define "BASE" "../../../.." */

if (!defined('EXPONENT')) exit('');

//if (expPermissions::check('manage',$loc)) {
if ($user->isAdmin()) {
	global $router;
	if (expTemplate::getModuleViewFile($loc->mod,'_userpermissions',false) == TEMPLATE_FALLBACK_VIEW) {
//		$template = new template('common','_userpermissions',$loc,false,'globalviews');
        $template = new template('common','_userpermissions',$loc);
	} else {
		//TODO
		//ADK - I hard coded the common module name into the new template declaration since the path resolver 
		// can't seem to figure out that we are in the common module and not the module that call this action.

		//$template = new template($loc->mod,'_userpermissions',$loc);
//		$template = new template('common','_userpermissions',$loc,false,'globalviews');
        $template = new template('common','_userpermissions',$loc);
	}
	$template->assign('user_form',1);
	
	$users = array();
	$modulename = expModules::controllerExists($loc->mod) ? expModules::getControllerClassName($loc->mod) : $loc->mod;
	$modclass = $modulename;
	$mod = new $modclass();
	$perms = $mod->permissions($loc->int);
	$have_users = 0;
	foreach (user::getAllUsers(false) as $u) {
		$have_users = 1;
		foreach ($perms as $perm=>$name) {
			$var = 'perms_'.$perm;
			if (expPermissions::checkUser($u,$perm,$loc,true)) {
				$u->$perm = 1;
			} else if (expPermissions::checkUser($u,$perm,$loc)) {
				$u->$perm = 2;
			} else {
				$u->$perm = 0;
			}
		}
		$users[] = $u;
	}
	
	$p[gt("User Name")] = 'username';
	$p[gt("First Name")] = 'firstname';
	$p[gt("Last Name")] = 'lastname';
	foreach ($mod->permissions() as $key => $value) {
//        $p[gt($value)]=$key;
        $p[gt($value)]='no-sort';
	}

	if (SEF_URLS == 1) {
		$page = new expPaginator(array(
		//'model'=>'user',
		'limit'=>(isset($_REQUEST['limit'])?intval($_REQUEST['limit']):20),
		'records'=>$users,
		//'sql'=>$sql,
		'order'=>'username',
		'dir'=>'ASC',
        'page'=>(isset($_REQUEST['page']) ? $_REQUEST['page'] : 1),
		'controller'=>$router->params['controller'],
//        'controller'=>$modulename,
		'action'=>$router->params['action'],
		'columns'=>$p,
		));
	} else {
		$page = new expPaginator(array(
		//'model'=>'user',
		'limit'=>(isset($_REQUEST['limit'])?intval($_REQUEST['limit']):20),
		'records'=>$users,
		//'sql'=>$sql,
		'order'=>'username',
		'dir'=>'ASC',
        'page'=>(isset($_REQUEST['page']) ? $_REQUEST['page'] : 1),
        'controller'=>expString::sanitize($_GET['module']),
        'action'=>$_GET['action'],
		'columns'=>$p,
		));
	}
        
	$template->assign('have_users',$have_users);
	$template->assign('users',$users);
	$template->assign('page',$page);
	$template->assign('perms',$perms);
    $template->assign('title',($modulename != 'navigationController' || ($modulename == 'navigationController' && !empty($loc->src))) ? $mod->name().' '.($modulename != 'containermodule' ? gt('module') : '').' ' : gt('Page'));

	$template->output();
} else {
	echo SITE_403_HTML;
}

?>
