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

if (!defined('EXPONENT')) exit('');

/**
 * Tag Picker Control
 *
 * @package    Subsystems-Forms
 * @subpackage Control
 */
class tagpickercontrol extends formcontrol { //FIXME we do NOT want a list of checkboxes for all the tags in the system

    var $flip = false;
    var $jsHooks = array();

    static function name() {
        return "Tag Picker";
    }

    static function isSimpleControl() {
        return false;
    }

    static function getFieldDefinition() {
        return array();
    }

    function __construct($collections = array(), $subtype = null) {
        global $db;

//		$this->tags = $db->selectNestedTree('expTags');
        $this->tags    = $db->selectObjects('expTags', 1);
        $this->subtype = isset($subtype) ? $subtype : '';
    }

    function toHTML($label, $name) {
        $this->class = "tagpicker";
        $this->id    = (empty($this->id)) ? $name : $this->id;
        $html        = "<div id=\"" . $this->id . "Control\" class=\"control " . $this->class . "";
        $html .= (!empty($this->required)) ? ' required">' : '">';
        $html .= "<label>";
        if (empty($this->flip)) {
            $html .= "<span class=\"label\">" . $label . "</span>";
            $html .= $this->controlToHTML($name, $label);
        } else {
            $html .= $this->controlToHTML($name, $label);
            $html .= "<span class=\"label\">" . $label . "</span>";
        }
        $html .= "</label>";
        $html .= "</div>";
        return $html;
    }

    function controlToHTML($name, $label) {
        $this->name = empty($this->name) ? $name : $this->name;
        $this->id   = empty($this->id) ? $name : $this->id;

        // get the selected tabs
        $selected_tags = array();
        foreach ($this->default as $tag) {
            $selected_tags[] = $tag->id;
        }
        //eDebug($this->tags);
        $html = '';
        foreach ($this->tags as $tag) {
            $checkbox          = new genericcontrol('checkbox');
            $checkbox->class   = "depth" . $tag->depth;
            $checkbox->id      = 'tag' . $tag->id;
            $checkbox->flip    = true;
            $checkbox->default = $tag->id;
            $name              = empty($this->subtype) ? 'expTag[]' : 'expTag[' . $this->subtype . '][]';
            $checkbox->checked = in_array($tag->id, $selected_tags);
            $html .= $checkbox->toHTML($tag->title, $name);
        }
        return $html;
    }
}

?>
