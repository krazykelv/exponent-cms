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

$item = $db->selectObject('calendar','id='.intval($_GET['id']));
if ($item) {
    if (expPermissions::check('delete',$loc)) {
        if ($item->is_recurring == 1) { // need to give user options
            $template = new template('calendarmodule','_form_delete');
            $eventdate = $db->selectObject('eventdate','id='.intval($_GET['date_id']));
            $template->assign('checked_date',$eventdate);
            $eventdates = $db->selectObjects('eventdate','event_id='.$item->id,'date');
    //		$eventdates = expSorter::sort(array('array'=>$eventdates,'sortby'=>'date', 'order'=>'ASC'));
            $template->assign('dates',$eventdates);
            $template->assign('event',$item);
            $template->output();
        }  else {
            // Process a regular delete
            include(BASE . 'framework/modules-1/calendarmodule/actions/delete.php');
        }
    } else {
   		echo SITE_403_HTML;
   	}
} else {
	echo SITE_404_HTML;
}

?>