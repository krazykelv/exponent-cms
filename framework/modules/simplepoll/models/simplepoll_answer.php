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

/**
 * @subpackage Models
 * @package Modules
 */

class simplepoll_answer extends expRecord {
//	public $table = 'simplepoll_answer';
    public $has_one = array('simplepoll_question');
    public $default_sort_field = 'rank';

//
//    protected $attachable_item_types = array(
//        'content_expFiles'=>'expFile'
//    );

//	public $validates = array(
//		'presence_of'=>array(
//			'body'=>array('message'=>'Body is a required field.'),
//		));
		
}

?>