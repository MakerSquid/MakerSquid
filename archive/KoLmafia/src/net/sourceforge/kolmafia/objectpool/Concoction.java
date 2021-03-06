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

package net.sourceforge.kolmafia.objectpool;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.java.dev.spellcast.utilities.LockableListModel;
import net.java.dev.spellcast.utilities.SortedListModel;
import net.sourceforge.kolmafia.AdventureResult;
import net.sourceforge.kolmafia.KoLCharacter;
import net.sourceforge.kolmafia.KoLConstants;
import net.sourceforge.kolmafia.RequestLogger;
import net.sourceforge.kolmafia.persistence.ConcoctionDatabase;
import net.sourceforge.kolmafia.persistence.ItemDatabase;
import net.sourceforge.kolmafia.persistence.Preferences;
import net.sourceforge.kolmafia.request.MallPurchaseRequest;
import net.sourceforge.kolmafia.utilities.StringUtilities;

/**
 * Internal class used to represent a single concoction. It contains all the information needed to actually make the
 * item.
 */

public class Concoction
	implements Comparable
{
	private static final int FOOD_PRIORITY = 1;
	private static final int BOOZE_PRIORITY = 2;
	private static final int SPLEEN_PRIORITY = 3;
	private static final int NO_PRIORITY = 0;

	private String name;

	public final AdventureResult concoction;

	private final int yield;
	private final int mixingMethod;
	private int sortOrder;

	private final boolean isTorsoItem;
	private final boolean isReagentPotion;

	private boolean wasPossible;

	private boolean visited;

	private final List ingredients;
	private AdventureResult[] ingredientArray;
	private int allocated;
	public static int debugId = Integer.MAX_VALUE;
	public static boolean debug = false;

	public int price;
	public int creatable;
	public int queued;
	public int queuedPulls;
	public int initial;
	public int pullable;
	public int total;
	public int visibleTotal;

	private int fullness, inebriety, spleenhit;
	private float mainstatGain;

	public Concoction( final AdventureResult concoction, final int mixingMethod )
	{
		this.concoction = concoction;

		this.wasPossible = false;
		this.mixingMethod = mixingMethod;

		if ( concoction == null )
		{
			this.yield = 1;
			this.name = "unknown";
			this.isTorsoItem = false;
			this.isReagentPotion = false;
			this.fullness = 0;
			this.inebriety = 0;
			this.spleenhit = 0;
			this.mainstatGain = 0.0f;
		}
		else
		{
			int consumeType = ItemDatabase.getConsumptionType( concoction.getItemId() );
			this.yield = Math.max( concoction.getCount(), 1 );
			this.name = concoction.getName();
			this.isTorsoItem = consumeType == KoLConstants.EQUIP_SHIRT;

			this.isReagentPotion =
				(this.mixingMethod == KoLConstants.COOK_REAGENT || this.mixingMethod == KoLConstants.SUPER_REAGENT) &&
				(consumeType == KoLConstants.CONSUME_USE || consumeType == KoLConstants.CONSUME_MULTIPLE);

			this.setConsumptionData();
		}

		this.ingredients = new ArrayList();
		this.ingredientArray = new AdventureResult[ 0 ];

		this.price = -1;

		this.resetCalculations();
	}

	public Concoction( final String name, final int price )
	{
		this( (AdventureResult) null, KoLConstants.NOCREATE );

		this.name = name;
		this.price = price;

		this.resetCalculations();
		this.setConsumptionData();
	}

	private void setConsumptionData()
	{
		this.fullness = ItemDatabase.getFullness( this.name );
		this.inebriety = ItemDatabase.getInebriety( this.name );
		this.spleenhit = ItemDatabase.getSpleenHit( this.name );

		this.sortOrder = this.fullness > 0 ? FOOD_PRIORITY :
			this.inebriety > 0 ? BOOZE_PRIORITY :
			this.spleenhit > 0 ? SPLEEN_PRIORITY :
			NO_PRIORITY;

		this.setStatGain();
	}

	public void setStatGain()
	{
		String range = "+0.0";
		switch ( KoLCharacter.mainStat() )
		{
		case KoLConstants.MUSCLE:
			range = ItemDatabase.getMuscleRange( this.name );
			break;
		case KoLConstants.MYSTICALITY:
			range = ItemDatabase.getMysticalityRange( this.name );
			break;
		case KoLConstants.MOXIE:
			range = ItemDatabase.getMoxieRange( this.name );
			break;
		}
		this.mainstatGain = StringUtilities.parseFloat( range );
	}

	public boolean usesIngredient( int itemId )
	{
		for ( int i = 0; i < this.ingredientArray.length; ++i )
		{
			if ( this.ingredientArray[ i ].getItemId() == itemId )
			{
				return true;
			}
		}

		return false;
	}

	public boolean usesIngredient( AdventureResult ar )
	{
		return this.usesIngredient( ar.getItemId() );
	}

	public int getYield()
	{
		if ( ConcoctionDatabase.tripleReagent && this.isReagentPotion() )
		{
			return 3 * this.yield;
		}

		return this.yield;
	}

	public boolean isReagentPotion()
	{
		return this.isReagentPotion;
	}

	public int compareTo( final Object other )
	{
		if ( other == null || !( other instanceof Concoction ) )
		{
			return -1;
		}
		
		Concoction o = (Concoction) other;
		
		if ( this.name == null )
		{
			return o.name == null ? 0 : 1;
		}

		if ( o.name == null )
		{
			return -1;
		}

		if ( this.sortOrder !=  o.sortOrder )
		{
			return this.sortOrder - o.sortOrder;
		}

		boolean thisCantConsume = false, oCantConsume = false;
		int limit;

		switch ( this.sortOrder )
		{
		case NO_PRIORITY:
			return this.name.compareToIgnoreCase( o.name );
			
		case FOOD_PRIORITY:
			limit = KoLCharacter.getFullnessLimit() - KoLCharacter.getFullness()
				- ConcoctionDatabase.getQueuedFullness();
			thisCantConsume = this.fullness > limit;
			oCantConsume = o.fullness > limit;
			break;
		
		case BOOZE_PRIORITY:
			limit = KoLCharacter.getInebrietyLimit() - KoLCharacter.getInebriety()
				- ConcoctionDatabase.getQueuedInebriety();
			thisCantConsume = this.inebriety > limit;
			oCantConsume = o.inebriety > limit;
			break;
		
		case SPLEEN_PRIORITY:
			limit = KoLCharacter.getSpleenLimit() - KoLCharacter.getSpleenUse()
				- ConcoctionDatabase.getQueuedSpleenHit();
			thisCantConsume = this.spleenhit > limit;
			oCantConsume = o.spleenhit > limit;
		}
		if ( Preferences.getBoolean( "sortByRoom" ) && (thisCantConsume != oCantConsume) )
		{
			return thisCantConsume ? 1 : -1;
		}

		float adventures1 = ItemDatabase.getAdventureRange( this.name );
		float adventures2 = ItemDatabase.getAdventureRange( o.name );

		if ( adventures1 != adventures2 )
		{
			return adventures2 - adventures1 > 0.0f ? 1 : -1;
		}		

		int fullness1 = this.fullness;
		int fullness2 = o.fullness;

		if ( fullness1 != fullness2 )
		{
			return fullness2 - fullness1;
		}

		int inebriety1 = this.inebriety;
		int inebriety2 = o.inebriety;

		if ( inebriety1 != inebriety2 )
		{
			return inebriety2 - inebriety1;
		}

		int spleenhit1 = this.spleenhit;
		int spleenhit2 = o.spleenhit;

		if ( spleenhit1 != spleenhit2 )
		{
			return spleenhit2 - spleenhit1;
		}

		float gain1 = this.mainstatGain;
		float gain2 = o.mainstatGain;

		if ( gain1 != gain2 )
		{
			return gain2 - gain1 > 0.0f ? 1 : -1;
		}

		return this.name.compareToIgnoreCase( o.name );
	}

	public boolean equals( final Object o )
	{
		if ( o == null || !( o instanceof Concoction ) )
		{
			return false;
		}

		if ( this.name == null )
		{
			return ( (Concoction) o ).name == null;
		}

		if ( ( (Concoction) o ).name == null )
		{
			return false;
		}

		return this.name.equals( ( (Concoction) o ).name );
	}

	public AdventureResult getItem()
	{
		return this.concoction;
	}

	public int getItemId()
	{
		return this.concoction == null ? -1 : this.concoction.getItemId();
	}

	public String getName()
	{
		return this.name;
	}

	public int getInitial()
	{
		return this.initial;
	}

	public int getAvailable()
	{
		return this.visibleTotal;
	}

	public int getQueued()
	{
		return this.queued;
	}

	public int getPrice()
	{
		return this.price;
	}

	public int getFullness()
	{
		return this.fullness;
	}

	public int getInebriety()
	{
		return this.inebriety;
	}

	public int getSpleenHit()
	{
		return this.spleenhit;
	}

	public boolean hasIngredients( final AdventureResult[] ingredients )
	{
		AdventureResult[] ingredientTest = this.ingredientArray;
		if ( ingredientTest.length != ingredients.length )
		{
			return false;
		}

		int[] ingredientTestIds = new int[ ingredients.length ];
		for ( int j = 0; j < ingredientTestIds.length; ++j )
		{
			ingredientTestIds[ j ] = ingredientTest[ j ].getItemId();
		}

		boolean foundMatch = true;
		for ( int j = 0; j < ingredients.length && foundMatch; ++j )
		{
			foundMatch = false;
			for ( int k = 0; k < ingredientTestIds.length && !foundMatch; ++k )
			{
				foundMatch |= ingredients[ j ].getItemId() == ingredientTestIds[ k ];
				if ( foundMatch )
				{
					ingredientTestIds[ k ] = -1;
				}
			}
		}

		return foundMatch;
	}

	public void queue( final LockableListModel globalChanges, final ArrayList localChanges, final int amount )
	{
		this.queue( globalChanges, localChanges, amount, true );
	}

	public void queue( final LockableListModel globalChanges, final ArrayList localChanges, final int amount, boolean adjust )
	{
		if ( amount <= 0 )
		{
			return;
		}

		if ( this.concoction == null )
		{
			if ( adjust )
			{
				this.queued += amount;
			}

			return;
		}

		int decrementAmount = Math.min( this.initial, amount );
		int overAmount = Math.min( this.creatable, amount - decrementAmount );
		int pullAmount = amount - decrementAmount - overAmount;
		if ( this.price > 0 )
		{
			pullAmount = 0;
		}
		
		if ( pullAmount != 0 )
		{
			ConcoctionDatabase.queuedPullsUsed += pullAmount;
		}

		// Tiny plastic swords and Legend keys are special in that they
		// are not used up.

		if ( this.concoction.getItemId() != ItemPool.PLASTIC_SWORD && this.concoction.getItemId() != ItemPool.BORIS_KEY && this.concoction.getItemId() != ItemPool.JARLSBERG_KEY && this.concoction.getItemId() != ItemPool.SNEAKY_PETE_KEY )
		{
			AdventureResult ingredient = this.concoction.getInstance( decrementAmount );
			AdventureResult.addResultToList( globalChanges, ingredient );
			AdventureResult.addResultToList( localChanges, ingredient );
		}

		int advs = ConcoctionDatabase.ADVENTURE_USAGE[ this.mixingMethod ] * overAmount;
		if ( advs != 0 )
		{
			ConcoctionDatabase.queuedAdventuresUsed += advs;
		}

		if ( this.mixingMethod == KoLConstants.STILL_BOOZE || this.mixingMethod == KoLConstants.STILL_MIXER )
		{
			ConcoctionDatabase.queuedStillsUsed += overAmount;
		}

		if ( adjust )
		{
			this.queued += amount;
			this.queuedPulls += pullAmount;
		}
		
		if ( this.price > 0 ||
			!ConcoctionDatabase.isPermittedMethod( this.mixingMethod ) )
		{
			return;
		}

		// Recipes that yield multiple units require smaller
		// quantities of ingredients.

		int mult = this.getYield();
		int icount = ( overAmount + ( mult - 1 ) ) / mult;
		for ( int i = 0; i < this.ingredientArray.length; ++i )
		{
			AdventureResult ingredient = this.ingredientArray[ i ];
			Concoction c = ConcoctionPool.get( ingredient );
			c.queue( globalChanges, localChanges, icount * ingredient.getCount(), false );
		}

		// Recipes that yield multiple units might result in
		// extra product which can be used for other recipes.

		int excess = mult * icount - overAmount;
		if ( excess > 0	 )
		{
		}
	}

	public void resetCalculations()
	{
		this.initial = -1;
		this.creatable = 0;
		this.pullable = 0;
		this.total = 0;

		this.allocated = 0;

		if ( this.concoction == null && this.name != null )
		{
			this.initial = KoLCharacter.getAvailableMeat() / this.price;
			this.creatable = 0;
			this.total = this.initial;
			this.visibleTotal = this.initial;
		}
	}
	
	public void setPullable( final int pullable )
	{
		this.pullable = pullable;
		this.total += pullable;
		this.visibleTotal += pullable;
	}

	public void setPossible( final boolean wasPossible )
	{
		this.wasPossible = wasPossible;
	}

	public boolean wasPossible()
	{
		return this.wasPossible;
	}

	public void addIngredient( final AdventureResult ingredient )
	{
		SortedListModel uses = ConcoctionDatabase.knownUses.get( ingredient.getItemId() );
		if ( uses == null )
		{
			uses = new SortedListModel();
			ConcoctionDatabase.knownUses.set( ingredient.getItemId(), uses );
		}

		uses.add( this.concoction );
		this.ingredients.add( ingredient );

		this.ingredientArray = new AdventureResult[ this.ingredients.size() ];
		this.ingredients.toArray( this.ingredientArray );
	}

	public int getMixingMethod()
	{
		return this.mixingMethod;
	}

	public AdventureResult[] getIngredients()
	{
		return this.ingredientArray;
	}

	public void calculate2()
	{
		int maxSuccess = this.initial;
		int minFailure = Integer.MAX_VALUE;
		int guess = maxSuccess + 1;
		ArrayList visited = new ArrayList();
		Iterator i;
		
		int id = this.getItemId();
		if ( id == Concoction.debugId )
		{
			Concoction.debug = true;
		}

		while ( true )
		{
			int res = this.canMake( guess, visited );
			
			if ( Concoction.debug )
			{
				RequestLogger.printLine( this.name + ".canMake(" + guess +
					") => " + res );
				RequestLogger.printLine();
			}

			if ( res >= guess )
			{	// guess was good, try a higher guess
				maxSuccess = guess;
			}
			else
			{	// guess was too high, try lower
				minFailure = guess;
				// In this situation, the algorithm tends to produce estimates
				// that are way too low.  Bump it up to the midpoint of the
				// range, so that the worst-case behavior is the O(log n) of
				// a binary search, not the O(n) of a linear search.
				res = Math.max( res, (maxSuccess + minFailure) / 2 );
			}
			if ( maxSuccess + 1 >= minFailure ) break;
			guess = Math.min( Math.max( res, maxSuccess + 1 ), minFailure - 1 );
			
			i = visited.iterator();
			while ( i.hasNext() )
			{	// clean up for next iteration of this item
				Concoction c = (Concoction) i.next();
				c.allocated = 0;
			}
		}

		i = visited.iterator();
		while ( i.hasNext() )
		{	// clean up for next item
			Concoction c = (Concoction) i.next();
			c.allocated = 0;
			c.visited = false;
		}

		if ( id == Concoction.debugId )
		{
			Concoction.debug = false;
		}

		this.total = maxSuccess;
		this.creatable = this.total - this.initial;
		if ( this.price > 0 && id != ItemPool.MEAT_PASTE &&
			id != ItemPool.MEAT_STACK && id != ItemPool.DENSE_STACK )
		{
			this.creatable -= KoLCharacter.getAvailableMeat() / this.price;
		}
		this.visibleTotal = this.total;
	}

	// Determine if the requested amount of this item can be made from
	// available ingredients.  Return value must be >= requested if true,
	// < requested if false.  The return value is treated as an estimate
	// of the exact amount that can be made, but isn't assumed to be
	// accurate.  This method will be called with distinct requested
	// values until some N is found to be possible, while N+1 is impossible.

	private int canMake( int requested, ArrayList visited )
	{
		if ( !this.visited )
		{
			visited.add( this );
			this.visited = true;
		}
		
		int alreadyHave = this.initial - this.allocated;
		if ( alreadyHave < 0 || requested <= 0 )
		{	// Already overspent this ingredient - either due to it being
			// present multiple times in the recipe, or being part of a
			// creation loop with insufficient initial quantities.
			return 0;
		}
		this.allocated += requested;
		int needToMake = requested - alreadyHave;
		if ( needToMake > 0 && this.price > 0 )
		{
			Concoction c = ConcoctionDatabase.meatLimit;
			int buyable = c.canMake( needToMake * this.price, visited ) / this.price;
			if ( Concoction.debug )
			{
				RequestLogger.printLine( "- " + this.name + " limited to " +
					buyable + " by price " + this.price );
			}
			alreadyHave += buyable;
			buyable = Math.min( buyable, needToMake );
			this.allocated -= buyable;
			needToMake -= buyable;
		}
		
		if ( this.mixingMethod == KoLConstants.NOCREATE )
		{	// No recipe for this item - don't bother with checking
			// ingredients, because there aren't any.  However, it's possible
			// that the total amount was preset greater than the initial, due
			// to some way of acquiring the item that isn't considered a
			// concoction (such as Hermit or Tr4pz0r trading).
			return alreadyHave + this.total - this.initial;		
		}
		if ( needToMake <= 0 )
		{	// Have enough on hand already.
			// Don't bother with calculating the number creatable:
			// * If this item is part of a creation loop, doing so
			// would result in an infinite recursion, as the excess
			// quantity gets chased around the loop.
			// * It may be completely wasted effort, if another ingredient
			// turns out to be the limiting factor.  If that doesn't turn
			// out to be the case, calc2 will eventually call us again, with
			// a requested amount that's large enough that this code block
			// won't be executed.
			return alreadyHave;
		}
		
		if ( !ConcoctionDatabase.isPermittedMethod( this.mixingMethod ) ||
			(this.isTorsoItem && !KoLCharacter.hasSkill( "Torso Awaregness" ) && !this.usesIngredient( ItemPool.SHIRT_KIT )) ||
			Preferences.getBoolean( "unknownRecipe" + this.getItemId() ) )
		{	// Impossible to create any more of this item.
			return alreadyHave;
		}
		
		int yield = this.getYield();
		needToMake = (needToMake + yield - 1) / yield;
		int minMake = Integer.MAX_VALUE;
		int lastMinMake = minMake;
		
		int len = this.ingredientArray.length;
		for ( int i = 0; minMake > 0 && i < len; ++i )
		{
			AdventureResult ingredient = this.ingredientArray[ i ];
			Concoction c = ConcoctionPool.get( ingredient );
			if ( c == null ) continue;
			int count = ingredient.getCount();
			
			if ( i == 0 && len == 2 &&
				this.ingredientArray[ 1 ].equals( ingredient ) )
			{	// Two identical ingredients - this is a moderately common
				// situation, and the algorithm produces better estimates if
				// it considers both quantities at once.
				count += this.ingredientArray[ 1 ].getCount();
				len = 1;
			}
			
			minMake = Math.min( minMake,
				c.canMake( needToMake * count, visited ) / count );
			if ( Concoction.debug )
			{
				RequestLogger.printLine( "- " + this.name + 
					(lastMinMake == minMake ?
						" not limited" : " limited to " + minMake) +
					" by " + c.name );
				lastMinMake = minMake;
			}
		}
		
		// Meat paste is an implicit ingredient

		if ( minMake > 0 && this.mixingMethod == KoLConstants.COMBINE &&
			!KoLCharacter.inMuscleSign() )
		{
			Concoction c = ConcoctionPool.get( ItemPool.MEAT_PASTE );
			minMake = Math.min( minMake, c.canMake( needToMake, visited ) );
			if ( Concoction.debug )
			{
				RequestLogger.printLine( "- " + this.name + 
					(lastMinMake == minMake ?
						" not limited" : " limited to " + minMake) +
					" by implicit meat paste" );
				lastMinMake = minMake;
			}
		}

		// Adventures are also considered an ingredient

		int advs = ConcoctionDatabase.ADVENTURE_USAGE[ this.mixingMethod ];
		if ( minMake > 0 && advs != 0 )
		{
			Concoction c = ConcoctionDatabase.adventureLimit;
			minMake = Math.min( minMake,
				c.canMake( needToMake * advs, visited ) / advs );
			if ( Concoction.debug )
			{
				RequestLogger.printLine( "- " + this.name + 
					(lastMinMake == minMake ?
						" not limited" : " limited to " + minMake) +
					" by adventures" );
				lastMinMake = minMake;
			}
		}

		// Still uses are also considered an ingredient.

		if ( minMake > 0 && (this.mixingMethod == KoLConstants.STILL_MIXER ||
			this.mixingMethod == KoLConstants.STILL_BOOZE) )
		{
			Concoction c = ConcoctionDatabase.stillsLimit;
			minMake = Math.min( minMake, c.canMake( needToMake, visited ) );
			if ( Concoction.debug )
			{
				RequestLogger.printLine( "- " + this.name + 
					(lastMinMake == minMake ?
						" not limited" : " limited to " + minMake) +
					" by stills" );
				lastMinMake = minMake;
			}
		}

		this.allocated -= Math.min( minMake, needToMake ) * yield;
		return alreadyHave + minMake * yield;
	}


	public int getMeatPasteNeeded( final int quantityNeeded )
	{
		// Avoid mutual recursion.

		int create = quantityNeeded - this.initial;
		if ( this.mixingMethod != KoLConstants.COMBINE || KoLCharacter.inMuscleSign() || create <= 0 )
		{
			return 0;
		}

		// Count all the meat paste from the different
		// levels in the creation tree.

		int runningTotal = create;
		for ( int i = 0; i < this.ingredientArray.length; ++i )
		{
			Concoction ingredient = ConcoctionPool.get( this.ingredientArray[ i ] );

			runningTotal += ingredient.getMeatPasteNeeded( create );
		}

		return runningTotal;
	}

	public int getAdventuresNeeded( final int quantityNeeded )
	{
		// If we can't make this item, it costs no adventures to use
		// the quantity on hand.
		if ( !ConcoctionDatabase.PERMIT_METHOD[ this.mixingMethod ] )
		{
			return 0;
		}

		int create = quantityNeeded - this.initial;
		if ( create <= 0 )
		{
			return 0;
		}

		// Heuristic/kludge: don't count making base booze by
		// fermenting juniper berries, for example.

		if ( concoction.getCount() > 1 )
		{
			return 0;
		}

		int runningTotal = ConcoctionDatabase.ADVENTURE_USAGE[ this.mixingMethod ] * create;

		// If this creation method takes no adventures, no recursion

		if ( runningTotal == 0 )
		{
			return 0;
		}

		// Count adventures from all levels in the creation tree.

		for ( int i = 0; i < this.ingredientArray.length; ++i )
		{
			Concoction ingredient = ConcoctionPool.get( this.ingredientArray[ i ] );

			runningTotal += ingredient.getAdventuresNeeded( create );
		}

		return runningTotal;
	}

	/**
	 * Returns the string form of this concoction. This is basically the display name for the item created.
	 */

	public String toString()
	{
		return this.name;
	}
}
