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

global $db;

$num_version = expVersion::getVersion();
$db_version = $db->selectObject('version','1');
if (empty($db_version)) {
    $db_version = new stdClass();
    $db_version->major = 1;
    $db_version->minor = 0;
    $db_version->revision = 0;
    $db_version->type = '';
    $db_version->iteration = '';
    $db_version->builddate = '';
}

?>
<h2><?php echo gt('Upgrade Scripts'); ?></h2>
<p>
<?php 
if (isset($_REQUEST['run'])) {
    echo gt("Exponent has performed the following upgrades").':';
} else {
    echo gt("Exponent will perform the following upgrades").':';
}

//display the upgrade scripts
$upgrade_dir = 'upgrades';
if (is_readable($upgrade_dir)) {
    $i = 0;
    if (is_readable('include/upgradescript.php')) include_once('include/upgradescript.php');
    $dh = opendir($upgrade_dir);
    echo '<form method="post" action="index.php">';
    if (isset($_REQUEST['run'])) {
        echo '<input type="hidden" name="page" value="final" />';
        echo '<input type="hidden" name="upgrade" value="1" />';
    } else {
        echo '<input type="hidden" name="page" value="upgrade-3" />';
        echo '<input type="hidden" name="run" value="1" />';
    }
    echo '<ol>';
    while (($file = readdir($dh)) !== false) {
        if (is_readable($upgrade_dir . '/' . $file) && is_file($upgrade_dir . '/' . $file) && substr($file, -4, 4) == '.php') {
            include_once($upgrade_dir . '/' . $file);
            $classname     = substr($file, 0, -4);
            /**
             * Stores the upgradescript object
             * @var \upgradescript $upgradescript
             * @name $upgradescript
             */
            $upgradescript = new $classname;
//            if ($upgradescript->checkVersion($num_version) && $upgradescript->needed($num_version)) {
            if ($upgradescript->checkVersion($db_version) && $upgradescript->needed()) {
                echo '<li>';
                if (isset($_REQUEST['run'])) {
                    echo '<h3>' . $upgradescript->name() . '</h3>';
                    if (!$upgradescript->optional || ($upgradescript->optional && !empty($_POST[$classname]))) {
                        echo '<p class="success">' . $upgradescript->upgrade();
                    } else {
                        echo '<p class="failed"> '.gt('Not Selected to Run');
                    }
                } else {
                    if ($upgradescript->optional) {
                        echo '<input type="checkbox" name="'.$classname.'" value="1" class="checkbox" style="margin-top: 7px;"><label class="label "><h3>'. $upgradescript->name().'</h3></label></b>';
                    } else {
                        echo '<input type="checkbox" name="'.$classname.'" value="1" checked="1" disabled="1" class="checkbox" style="margin-top: 7px;"><label class="label "><h3>'. $upgradescript->name().'</h3></label></b>';
                    }
                    echo '<p>' . $upgradescript->description();
                }
                echo '</p></li>';
                $i++;
            }
        }
    }
    if ($i==0) {
        echo '<li>
        <h3>'.gt('None Required').'</h3>
        <p>'.gt('You\'re good to go. Click next to finish up.').'</p>
        </li>';
    }
    echo '</ol>';
    if (isset($_REQUEST['run']) || $i==0) {
        echo '<button class="awesome large green">'; echo gt('Finish Upgrade'); echo '</button>';
    } else {
        echo '<button class="awesome large green">'; echo gt('Run Upgrades'); echo '</button>';
    }
    echo '</form>';
}

?>
</p>
