/**
 * Copyright (c) 2005-2009, KoLmafia development team
 * http://kolmafia.sourceforge.net/
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *  [1] Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *  [2] Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in
 *      the documentation and/or other materials provided with the
 *      distribution.
 *  [3] Neither the name "KoLmafia" nor the names of its contributors may
 *      be used to endorse or promote products derived from this software
 *      without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

package net.sourceforge.kolmafia.swingui.panel;

import net.sourceforge.kolmafia.AdventureResult;
import net.sourceforge.kolmafia.KoLConstants;
import net.sourceforge.kolmafia.RequestThread;
import net.sourceforge.kolmafia.StaticEntity;
import net.sourceforge.kolmafia.swingui.widget.AutoFilterTextField;

import net.sourceforge.kolmafia.request.UseItemRequest;

import net.sourceforge.kolmafia.persistence.ItemDatabase;

public class UseItemPanel
	extends InventoryPanel
{
	public UseItemPanel()
	{
		super( KoLConstants.inventory, false );
	}

	public AutoFilterTextField getWordFilter()
	{
		return new UsableItemFilterField();
	}

	public void actionConfirmed()
	{
		Object[] items = this.getDesiredItems( "Consume" );
		if ( items.length == 0 )
		{
			return;
		}

		for ( int i = 0; i < items.length; ++i )
		{
			RequestThread.postRequest( new UseItemRequest( (AdventureResult) items[ i ] ) );
		}
	}

	public void actionCancelled()
	{
		String name;
		Object[] values = this.elementList.getSelectedValues();

		for ( int i = 0; i < values.length; ++i )
		{
			name = ( (AdventureResult) values[ i ] ).getName();
			if ( name != null )
			{
				StaticEntity.openSystemBrowser( "http://kol.coldfront.net/thekolwiki/index.php/Special:Search?search=" + name );
			}
		}
	}

	private class UsableItemFilterField
		extends FilterItemField
	{
		public boolean isVisible( final Object element )
		{
			AdventureResult item = (AdventureResult) element;
			int itemId = item.getItemId();

			if ( !UsableItemFilterField.this.notrade && !ItemDatabase.isTradeable( itemId ) )
			{
				return false;
			}

			boolean filter = false;

			switch ( ItemDatabase.getConsumptionType( itemId ) )
			{
			case KoLConstants.CONSUME_EAT:
				filter = UsableItemFilterField.this.food;
				break;

			case KoLConstants.CONSUME_DRINK:
				filter = UsableItemFilterField.this.booze;
				break;

			case KoLConstants.CONSUME_USE:
			case KoLConstants.MESSAGE_DISPLAY:
			case KoLConstants.INFINITE_USES:
			case KoLConstants.CONSUME_MULTIPLE:
			case KoLConstants.GROW_FAMILIAR:
			case KoLConstants.CONSUME_ZAP:
			case KoLConstants.MP_RESTORE:
			case KoLConstants.HP_RESTORE:
			case KoLConstants.HPMP_RESTORE:
				filter = UsableItemFilterField.this.other;
				break;

			case KoLConstants.EQUIP_FAMILIAR:
			case KoLConstants.EQUIP_ACCESSORY:
			case KoLConstants.EQUIP_HAT:
			case KoLConstants.EQUIP_PANTS:
			case KoLConstants.EQUIP_SHIRT:
			case KoLConstants.EQUIP_WEAPON:
			case KoLConstants.EQUIP_OFFHAND:
				filter = UsableItemFilterField.this.equip;
				break;

			default:
				return false;
			}

			return filter && super.isVisible( element );
		}
	}
}

