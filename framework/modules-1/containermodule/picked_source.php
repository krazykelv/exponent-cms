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

define('SCRIPT_EXP_RELATIVE','framework/modules-1/containermodule/');
define('SCRIPT_FILENAME','picked_source.php');

include_once('../../../exponent.php');

$src = expString::sanitize($_GET['ss']);
$mod = expString::sanitize($_GET['sm']);

$secref = $db->selectObject("sectionref","module='".$mod."' AND source='".$src."'");
if (!isset($secref->description)) $secref->description = '';

?>
<html>
<head>
<script type="text/javascript">
function saveSource() {
	window.opener.sourcePicked("<?php echo $_GET['ss']; ?>","<?php echo str_replace(array("\"","\r\n"),array("\\\"","\\r\\n"),$secref->description); ?>");
	window.close();
	
}
</script>
</head>
<body onload="saveSource()">
</body>
</html>