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

package net.sourceforge.kolmafia.webui;

import java.util.regex.Matcher;
import java.util.regex.Pattern;


import net.sourceforge.kolmafia.request.FightRequest;
import net.sourceforge.kolmafia.utilities.StringUtilities;

public abstract class BeerPongDecorator
{
	private static final Pattern ROUND1_PATTERN = Pattern.compile( "The pirate lobs his ball \\w+ your cups. &quot;(.*?)&quot; he taunts" );
	private static final Pattern ROUND2_PATTERN = Pattern.compile( "&quot;However -- (.*?)&quot;" );
	private static final Pattern ROUND3_PATTERN = Pattern.compile( "and growls &quot;(.*?)&quot;" );

	public static final void decorate( final StringBuffer buffer )
	{
		String insult = BeerPongDecorator.findInsult( buffer.toString() );
		if ( insult == null )
		{
			return;
		}

		int index = FightRequest.findPirateRetort( insult );
		if ( index == 0 )
		{
			return;
		}

		String retort = FightRequest.findPirateRetort( index );
		if ( retort == null )
		{
			return;
		}

		StringUtilities.singleStringReplace( buffer, ">" + retort, " selected>" + retort );
	}

	public static final String findInsult( final String text )
	{
		Matcher matcher = BeerPongDecorator.ROUND1_PATTERN.matcher( text );
		if ( matcher.find() )
		{
			return matcher.group(1);
		}

		matcher = BeerPongDecorator.ROUND2_PATTERN.matcher( text );
		if ( matcher.find() )
		{
			return matcher.group(1);
		}

		matcher = BeerPongDecorator.ROUND3_PATTERN.matcher( text );
		if ( matcher.find() )
		{
			return matcher.group(1);
		}

		return null;
	}
}
