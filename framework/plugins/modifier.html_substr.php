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

/**
 * Smarty plugin
 * http://www.smarty.net/forums/viewtopic.php?t=533
----------------------------------------------------- 
 * File: modifier.html_substr.php
 * Type: modifier
 * Name: html_substr
 * Version: 1.2
 * Date: January 13th, 2010
 * Purpose: Cut a string preserving any tag nesting and matching.
 * Author: Original Javascript Code: Benjamin Lupu <lupufr
 *
 * @aol.com>
 *             Translation to PHP & Smarty: Edward Dale <scompt@scompt.com>
 *             Modification to add a string: Sebastian Kuhlmann <sebastiankuhlmann@web.de>
 *             Modification to add user defined closing text before closing tag if tag matches specified elements and added read more link with variable text:
 *             Avi J Liebowitz avij.com
 *             Example Usage {$htmlString|html_substr:<lengh>:<string_to_add>:<link>:<link_text>}
-------------------------------------------------------------
 * @package    Smarty-Plugins
 * @subpackage Modifier
 *
 * @param $string
 * @param $length
 * @param $addstring
 * @param $link
 * @param $link_text
 *
 * @return string
 */

function smarty_modifier_html_substr($string, $length, $addstring, $link, $link_text) {
    // only execute if text is longer than desired length
    if (strlen($string) > $length) {
        if (!empty($string) && $length > 0) {
            $isText = true;
            $ret = "";
            $i = 0;

            $currentChar = "";
            $lastSpacePosition = -1;
            $lastChar = "";

            $tagsArray = array();
            $currentTag = "";
            $tagLevel = 0;

            $noTagLength = strlen(strip_tags($string));

            // Parser loop
            for ($j = 0; $j < strlen($string); $j++) {

                $currentChar = substr($string, $j, 1);
                $ret .= $currentChar;

                // Lesser than event
                if ($currentChar == "<") $isText = false;

                // Character handler
                if ($isText) {

                    // Memorize last space position
                    if ($currentChar == " ") {
                        $lastSpacePosition = $j;
                    } else {
                        $lastChar = $currentChar;
                    }

                    $i++;
                } else {
                    $currentTag .= $currentChar;
                }

                // Greater than event
                if ($currentChar == ">") {
                    $isText = true;

                    // Opening tag handler
                    if ((strpos($currentTag, "<") !== FALSE) &&
                        (strpos($currentTag, "/>") === FALSE) &&
                        (strpos($currentTag, "</") === FALSE)
                    ) {

                        // Tag has attribute(s)
                        if (strpos($currentTag, " ") !== FALSE) {
                            $currentTag = substr($currentTag, 1, strpos($currentTag, " ") - 1);
                        } else {
                            // Tag doesn't have attribute(s)
                            $currentTag = substr($currentTag, 1, -1);
                        }

                        array_push($tagsArray, $currentTag);

                    } else if (strpos($currentTag, "</") !== FALSE) {
                        array_pop($tagsArray);
                    }

                    $currentTag = "";
                }

                if ($i >= $length) {
                    break;
                }
            }

            // Cut HTML string at last space position
            if ($length < $noTagLength) {
                if ($lastSpacePosition != -1) {
                    $ret = substr($string, 0, $lastSpacePosition);
                } else {
                    $ret = substr($string, $j);
                }
            }

            if (sizeof($tagsArray) != 0) {
                // Close broken XHTML elements
                while (sizeof($tagsArray) != 0) {
                    if (sizeof($tagsArray) > 1) {
                        $aTag = array_pop($tagsArray);
                        $ret .= "</" . $aTag . ">";
                    } // You may add more tags here to put the link and added text before the closing tag
                    elseif ($aTag == 'p' || 'div') {
                        $aTag = array_pop($tagsArray);
                        $ret .= "</" . $aTag . ">";
                    } else {
                        $aTag = array_pop($tagsArray);
                        $ret .= "</" . $aTag . ">";
                    }
                }
            }
            if ($addstring != '') {
                $ret .= $addstring;
            }
            if ($link != '' && $link_text != '') {
                $ret .= "<a href=\"" . $link . "\" alt=\"" . $link_text . "\">" . $link_text . "</a>";
            }
        } else {
            $ret = "";
        }

        return ($ret);
    } else {
        return ($string);
    }
}

?> 