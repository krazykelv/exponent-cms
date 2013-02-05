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
/** @define "BASE" "../../../.." */

if (!defined('EXPONENT')) exit('');

expHistory::set('editable',array("module"=>"containermodule","action"=>"edit"));;
$container = null;
$iloc = new stdClass();
$cloc = new stdClass();
if (isset($_GET['id'])) {
	$container = $db->selectObject('container','id=' . intval($_GET['id']) );
	if ($container != null) {
		$iloc = unserialize($container->internal);
		$cloc = unserialize($container->external);
		$cloc->int = $container->id;
	}
} else {
    $container = new stdClass();
	$container->rank = $_GET['rank'];
}
$loc->src = urldecode($loc->src);

if (expPermissions::check('edit',$loc) || expPermissions::check('create',$loc) ||
	($iloc != null && expPermissions::check('manage',$iloc)) ||
	($cloc != null && expPermissions::check('delete',$cloc))
) {
	#
	# Initialize Container, in case its null
	#
	$secref = new stdClass();
	if (!isset($container->id)) {
		$secref->description = '';
		$container->view = '';
		$container->internal = expCore::makeLocation();
		$container->title = '';
		$container->rank = $_GET['rank'];
		$container->is_private = 0;
	} else {
		$container->internal = unserialize($container->internal);
		$secref = $db->selectObject('sectionref',"module='".$container->internal->mod."' AND source='".$container->internal->src."'");
	}

   	expSession::clearAllUsersSessionCache('containermodule');

	$template = new template('containermodule','_form_edit',$loc);
//	$template->assign('rerank', (isset($_GET['rerank']) ? 1 : 0) );
	$template->assign('rerank', (isset($_GET['rerank']) ? $_GET['rerank'] : 0) );
	$template->assign('container',$container);
	$template->assign('locref',$secref);
	$template->assign('is_edit', (isset($container->id) ? 1 : 0) );
	$template->assign('can_activate_modules',$user->is_acting_admin);
	$template->assign('current_section',expSession::get('last_section'));
	
	$haveclass = false;
	$mods = array();
	
	//$modules_list = (isset($container->id) ? expModules::modules_list() : exponent_modules_listActive());
	$modules_list = expModules::getActiveModulesAndControllersList();

	if (!count($modules_list)) { // No active modules
		$template->assign('nomodules',1);
	} else {
		$template->assign('nomodules',0);
	}
	
	//sort($modules_list);
	
	$js_init = '<script type="text/javascript">';
		
	foreach ($modules_list as $moduleclass) {
		$module = new $moduleclass();
		
		// Get basic module meta info
        $mod = new stdClass();
		$mod->name = $module->name();
		$mod->author = $module->author();
		$mod->description = $module->description();
//        $mod->name = $moduleclass::name();
//        $mod->author = $moduleclass::author();
//        $mod->description = $moduleclass::description();
		if (isset($container->view) && $container->internal->mod == $moduleclass) {
			$mod->defaultView = $container->view;
		} else $mod->defaultView = DEFAULT_VIEW;
		
		// Get support flags
		$mod->supportsSources = ($module->hasSources() ? 1 : 0);
		$mod->supportsViews  = ($module->hasViews()   ? 1 : 0);
//        $mod->supportsSources = ($moduleclass::hasSources() ? 1 : 0);
//        $mod->supportsViews  = ($moduleclass::hasViews()   ? 1 : 0);

		// Get a list of views
		$mod->views = expTemplate::listModuleViews($moduleclass);
		natsort($mod->views);
		
        // if (!$haveclass) {
        //  $js_init .=  exponent_javascript_class($mod,'Module');
        //  $js_init .=  "var modules = new Array();\r\n";
        //  $js_init .=  "var modnames = new Array();\r\n\r\n";
        //  $haveclass = true;
        // }
        // $js_init .=  "modules.push(" . exponent_javascript_object($mod,"Module") . ");\r\n";
        // $js_init .=  "modnames.push('" . $moduleclass . "');\r\n";
        $modules[$moduleclass] = $mod;
		$mods[$moduleclass] = $module->name();
//        $mods[$moduleclass] = $moduleclass::name();
	}
	//$js_init .= "\r\n</script>";
	
    array_multisort(array_map('strtolower', $mods), $mods);
	if (!array_key_exists($container->internal->mod, $mods) && !empty($container->id)) {
        $template->assign('error',gt('The module you are trying to edit is inactive. Please contact your administrator to activate this module.'));
	}
	$template->assign('user',$user);
	$template->assign('json_obj',json_encode($modules));
	$template->assign('modules',$mods);
	$template->assign('loc',$loc);
	$template->assign('back',expHistory::getLastNotEditable());
	$template->output();
} else {
	echo SITE_403_HTML;
}

?>
