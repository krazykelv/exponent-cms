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

function smarty_function_pageNextLink($params,&$smarty) {
	if ($params['page']->page < $params['page']->numberOfPages) {
		// initialize a couple of variables
		$class = isset($params['class']) ? $params['class'] : 'page-next';
		$text = isset($params['text']) ? $params['text'] : 'Next >';

		// if the designer specified an image then show it here
		if (isset($params['image'])) {
			$imgClass = isset($params['imageclass']) ? $params['imageclass'] : 'page-next-image';
			echo '<img class="'.$imgClass.'" src="'.$params['image'].'" />';
		}

		// spit out the link
		$newpage = $params['page']->page + 1;
		echo '<a class="'.$class.'" href="#" onclick="page('.$newpage.')">'.$text.'</a>';
	}
	//eDebug($page);	
}

?>
