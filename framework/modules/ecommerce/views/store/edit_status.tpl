{*
 * Copyright (c) 2004-2013 OIC Group, Inc.
 *
 * This file is part of Exponent
 *
 * Exponent is free software; you can redistribute
 * it and/or modify it under the terms of the GNU
 * General Public License as published by the Free
 * Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * GPL: http://www.gnu.org/licenses/gpl.txt
 *
 *}

{group label="Active/Inactive"|gettext}
{control type="hidden" name="tab_loaded[status]" value=1}
{control type="radiogroup" name="status[active_type]" label=" " items=$record->active_display item_descriptions=$record->active_display_desc columns=1 default=$record->active_type|default:0}
{/group}
{group label="Status"|gettext}
{control type="dropdown" name="status[product_status_id]" label=" " frommodel=product_status items=$status_display value=$record->product_status_id}
{icon controller="product_status" action="manage" text="Manage Product Statuses"|gettext}
{/group}
