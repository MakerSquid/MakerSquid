package com.prekog.adventure;

import java.util.ArrayList;
import java.util.List;

public class MonsterDetail {
	
	private List<String> actions = new ArrayList<String>();
	private String name = null;
	
	public void setName(String p) {name = p;}
	public String getName() {return name;}
	
	public void addAction(String p){actions.add(p);}
	public String getAction()
	{
		//return random action from the list of actions
		return actions.get(0);
	}

}
