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
/** @define "BASE" "../../.." */

if (!defined('EXPONENT')) exit('');

/**
 * Date/Time Control w/ Popup Date Picker and time w/ am/pm combo
 * text entry date and/or time w/ pop-up date selector
 *
 * @package    Subsystems-Forms
 * @subpackage Control
 */
class calendarcontrol extends formcontrol {

    var $disable_text = "";
    var $showtime = true;
    var $default_date = '';
    var $default_hour = '';
    var $default_min = '';
    var $default_ampm = '';

    static function name() {
        return "YAHOO! UI Calendar";
    }

    static function isSimpleControl() {
        return false;
    }

    static function getFieldDefinition() {
        return array(
            DB_FIELD_TYPE=> DB_DEF_TIMESTAMP);
    }

    // function yuicalendarcontrol($default = null, $disable_text = "",$showtime = true) {
    //     $this->disable_text = $disable_text;
    //     $this->default = $default;
    //     $this->showtime = $showtime;
    // 
    //     if ($this->default == null) {
    //         if ($this->disable_text == "") $this->default = time();
    //         else $this->disabled = true;
    //     }
    //     elseif ($this->default == 0) {
    //         $this->default = time();
    //     }
    // }

    function toHTML($label, $name) {
        if (!empty($this->id)) {
            $divID = ' id="' . $this->id . 'Control"';
            $for   = ' for="' . $this->id . '"';
        } else {
            $divID = '';
            $for   = '';
        }

        $disabled = $this->disabled != 0 ? "disabled" : "";
        $class    = empty($this->class) ? '' : $this->class;

        $html = "<div" . $divID . " class=\"" . $this->type . "-control control " . $class . $disabled . "\"";
        $html .= (!empty($this->required)) ? ' required">' : '>';
        //$html .= "<label>";
        if (empty($this->flip)) {
            $html .= $this->controlToHTML($name, $label);
        } else {
            $html .= "<label" . $for . " class=\"label\">" . $label . "</label>";
        }
        //$html .= "</label>";
        $html .= "</div>";
        return $html;
    }

    function controlToHTML($name, $label = null) {
        $assets_path = SCRIPT_RELATIVE . 'framework/core/subsystems/forms/controls/assets/';
        $html        = "
            <div id=\"calendar-container-" . $name . "\" class=\"yui3-skin-sam\"> </div>
            <div id=\"cal-container-" . $name . "\" class=\"control calendar-control\">
            <label for=\"" . $name . "\" class=\"label\">" . $label . "</label><input size=10 type=\"text\" id=\"date-" . $name . "\" name=\"date-" . $name . "\" value=\"" . $this->default_date . "\" class=\"text datebox\" />
            @ <input size=2 type=\"text\" id=\"time-h-" . $name . "\" name=\"time-h-" . $name . "\" value=\"" . $this->default_hour . "\" class=\"timebox\" maxlength=2/>
            : <input size=2 type=\"text\" id=\"time-m-" . $name . "\" name=\"time-m-" . $name . "\" value=\"" . $this->default_min . "\" class=\"timebox\" maxlength=2/>
            <select id=\"ampm-" . $name . "\" name=\"ampm-" . $name . "\">";

        if ($this->default_ampm == "AM") $html .= "<option selected>am</option><option>pm</option>";
        else $html .= "<option>am</option><option selected>pm</option>";
        $html .= "
            </select>
        </div>
        <div style=\"clear:both\"></div>
        ";

        $script = "
        YUI(EXPONENT.YUI3_CONFIG).use('node','calendar','datatype-date', function(Y) {
            // Our calendar bounding div id
            var boundingBoxId = '#calendar-container-" . $name . "',
            // This flag used to track mouse position
            isMouseOverCalendar = false,
            // A text field element that stores the date chosen in calendar
            currentValueContainer = '',
            calendar = new Y.Calendar({
                boundingBox: boundingBoxId,
                width: '340px',
                showPrevMonth: true,
                showNextMonth: true,
            });

            // These are text fields' ids to store dates in
            var dateField = '#date-" . $name . "';

            // To show calendar when user clicks on text fields
            Y.on('focus', function(event) {
                showCalendar(event)
            }, dateField);
            // To hide calendar when text fields loose focus
            Y.on('blur', function() {
                hideCalendar()
            }, dateField);

            // Tracking mouse position
            Y.on('mouseover', function () {
                isMouseOverCalendar = true;
            }, boundingBoxId);
            Y.on('mouseout', function () {
                isMouseOverCalendar = false;
            }, boundingBoxId);

            // On date selection, we update value of a text field and hide calendar window
            calendar.on('dateClick', function (event) {
                Y.one(currentValueContainer).set('value', Y.DataType.Date.format(event.date,{format:'" . DISPLAY_DATE_FORMAT . "'}));
                isMouseOverCalendar = false;
                hideCalendar();
            });

            var showCalendar = function (event) {
                // It's a text field that a user clicked on
                currentValueContainer = event.target;

                // Getting current date value in the text field
                    dateString = Y.one(currentValueContainer).get('value');

                // Clearing previously selected dates if any
                calendar.deselectDates();
                // If the text field had some date value before
                if (dateString) {
                    // Parsing the date string into JS Date value
                    var date = Y.DataType.Date.parse(dateString);
                    if (date) {
                        // Highlighting the date stored in the text field
                        calendar.selectDates(date);
                    } else {
                        date = new Date();
                    }
                    // Setting calendar date to show corresponding month
                    calendar.set('date', date);
                } else {
                    calendar.set('date', new Date());
                }
                // Finally render the calendar window
                calendar.render();

                // Required styles to show calendar in a proper position
                Y.one(boundingBoxId).setStyles({
                    display: 'block',
                    position: 'absolute'
                });
            };

            var hideCalendar = function () {
                if (!isMouseOverCalendar) {
                    Y.one(boundingBoxId).setStyle('display', 'none');
                }
            };

            // time input restriction to 12 hour
            Y.on('keyup',function(e){
                if (e.target.get('value')>12) {
                    e.target.set('value',12);
                }
                if (e.target.get('value')<0) {
                    e.target.set('value',0);
                }
            }, '#time-h-" . $name . "');

            // time input restriction to 12 hour
            Y.on('keyup',function(e){
                if (e.target.get('value')>59) {
                    e.target.set('value',59);
                }
                if (e.target.get('value')<0) {
                    e.target.set('value',0);
                }
            }, '#time-m-" . $name . "');
        });
        "; // end JS

        expJavascript::pushToFoot(array(
            "unique"  => 'zzcal' . $name,
            "yui3mods"=> 1,
            "content" => $script,
//            "src"=>""
        ));
        return $html;
    }

    static function parseData($original_name, $formvalues) {
        if (!empty($formvalues[$original_name])) {
            return strtotime($formvalues[$original_name]);
        } else return 0;
    }

    static function templateFormat($db_data, $ctl) {
        // if ($ctl->showtime) {
        //  return strftime(DISPLAY_DATETIME_FORMAT,$db_data);
        // }
        // else {
        //  return strftime(DISPLAY_DATE_FORMAT, $db_data);
        // }
    }

    // function form($object) {
    //  $form = new form();
    //  if (!isset($object->identifier)) {
    //      $object->identifier = "";
    //      $object->caption = "";
    //      $object->showtime = true;
    //  }
    // 
    //  $form->register("identifier",gt('Identifier'),new textcontrol($object->identifier));
    //  $form->register("caption",gt('Caption'), new textcontrol($object->caption));
    //  $form->register("showtime",gt('Show Time'), new checkboxcontrol($object->showtime,false));
    // 
    //  $form->register("submit","",new buttongroupcontrol(gt('Save'),"",bt'Cancel'),"",'editable'));
    //  return $form;
    // }

    static function update($values, $object) {
        if ($object == null) {
            $object          = new popupdatetimecontrol();
            $object->default = 0;
        }
        if ($values['identifier'] == "") {
            $post               = $_POST;
            $post['_formError'] = gt('Identifier is required.');
            expSession::set("last_POST", $post);
            return null;
        }
        $object->identifier = $values['identifier'];
        $object->caption    = $values['caption'];
        $object->showtime   = isset($values['showtime']);
        return $object;
    }

}

?>
