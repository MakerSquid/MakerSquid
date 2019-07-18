package com.prekog.adventure;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class GameData {
	
	private List<LocationDetail> locations = new ArrayList<LocationDetail>();
	private List<MonsterDetail> monsters = new ArrayList<MonsterDetail>();
	private CharacterStats character = new CharacterStats();

	public LocationDetail GetLocation()
	{
		Random generator = new Random(System.currentTimeMillis());
		Integer arraySize = locations.size();
		Integer index = generator.nextInt(arraySize);
		
		return locations.get(index);
	}
	
	public MonsterDetail GetMonster()
	{
		Random generator = new Random(System.currentTimeMillis());
		Integer arraySize = monsters.size();
		Integer index = generator.nextInt(arraySize);
		
		return monsters.get(index);
	}
	
	public void Init()
	{
		InitLocations();
		InitMonsters();
		
		InitCharacter();
	}
	
	private void InitCharacter() {
		character.Health = 100;
		character.Experience = 0;
		character.Gold = 50;		
	}
	
	public  String TakeDamage() {
		String result = "";		
		Random generator = new Random(System.currentTimeMillis());
		
		Integer index = generator.nextInt(3);
		
		character.Health -= index;

		if (index > 0) {
			result = String.format("\n\nYou take %s damage.", index);
		}
		else
		{
			result = "\n\nYou escape unharmed.";
		}
		
		return result;
	}
	
	public String GainExperience() {
		String result = "";				
		Random generator = new Random(System.currentTimeMillis());
		
		Integer index = generator.nextInt(3) + 1;
		character.Experience += index;
		
		if (index > 0 ) {
			result = String.format("\n\nYou gain %s experience.", index);
		}

		return result;
	}
	
	public String GainCurrency() {
		String result = "";
		Random generator = new Random(System.currentTimeMillis());
		
		Integer index = generator.nextInt(3);
		
		character.Gold += index;

		if (index > 0)
		{
			result = String.format("\n\nYou gain %s gold.", index);
		}

		return result;
	}

	private void InitLocations()
	{
		locations.add(new LocationDetail("As you pass what you thought was an empty cardboard box %s %s.", true));
		locations.add(new LocationDetail("You are attacked by %s. It %s.", true));
		locations.add(new LocationDetail("While wandering through a peaceful meadow you are attacked by %s that you failed to notice when you stopped to smell the flowers. It %s.", true));
		locations.add(new LocationDetail("You encounter %s. It %s.", true));
		//locations.add(new LocationDetail("You trip over %s.", false));
		//locations.add(new LocationDetail("You stumble upon a {monster} but it is asleep. You {health-restore}. [Health Restore]
		//locations.add(new LocationDetail("You find {item}.  It was just lying there in the grass. [Acquire Item]
	}
	
	private void InitMonsters()
	{
		monsters.add(new MonsterDetail());
		monsters.get(0).setName("a Walriz");
		monsters.get(0).addAction("attacks you with its bucket");
		
		monsters.add(new MonsterDetail());
		monsters.get(1).setName("a Fearsome Goggie");
		monsters.get(1).addAction("slobbers on you");
		//Drools on you.
		
		monsters.add(new MonsterDetail());
		monsters.get(2).setName("a Deadly Kitteh of Death");
		monsters.get(2).addAction("hacks up hairballs on you");
		//overcomes you with its cuteness.
		
		monsters.add(new MonsterDetail());
		monsters.get(3).setName("a Box Kat");
		monsters.get(3).addAction("jumps out and scares you");
		
		monsters.add(new MonsterDetail());
		monsters.get(4).setName("a Ninja Kat");
		monsters.get(4).addAction("sneaks up on you");
		
		monsters.add(new MonsterDetail());
		monsters.get(5).setName("a Sealing Kat");
		monsters.get(5).addAction("licks your face until your eyes swell shut");
		
		monsters.add(new MonsterDetail());
		monsters.get(6).setName("a Bazemint Kat");
		monsters.get(6).addAction("attempts to coerce you into smoking an herbal cigarette");
		
		monsters.add(new MonsterDetail());
		monsters.get(7).setName("a Squirzel");
		monsters.get(7).addAction("pelts you with nuts");
		
		monsters.add(new MonsterDetail());
		monsters.get(8).setName("a Chipotle Parrot");
		monsters.get(8).addAction("squawks a colorful phrase at you");
		
		monsters.add(new MonsterDetail());
		monsters.get(9).setName("a Zombie Kat");
		monsters.get(9).addAction("just lays there stinking");
		//Farts in your general direction.
	}

	public int getHealth() {
		return character.Health;
	}

	public int getExperience() {
		return character.Experience;
	}

	public void FullHeal() {
		character.Health = 100;
		
	}

	public int getCurrency() {
		return character.Gold;
	}
	
	public Boolean spendCurrency(Integer amount)
	{
		if(character.Gold > amount)
		{
			character.Gold -= amount;
			return true;
		}
		
		return false;
	}
}
