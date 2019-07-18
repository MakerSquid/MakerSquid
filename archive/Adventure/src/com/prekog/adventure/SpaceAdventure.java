package com.prekog.adventure;

import java.util.Random;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class SpaceAdventure extends Activity implements OnClickListener {
	
    private GameData data = new GameData();

	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Button button = (Button)findViewById(R.id.adventure);
        button.setOnClickListener(this);
        Button button2 = (Button)findViewById(R.id.heal);
        button2.setOnClickListener(this);
        
        data.Init();
    }

    // Implement the OnClickListener call back
    public void onClick(View v) {
        TextView textview = (TextView)findViewById(R.id.resultsText);
        TextView health = (TextView)findViewById(R.id.health);
        TextView experience = (TextView)findViewById(R.id.experience);
        TextView currency = (TextView)findViewById(R.id.currency);
   	 	String result = "";
              
        if (v.getId() == R.id.adventure)
        {      	 
 		      if (data.getHealth() > 10)
 		      {
	        	  LocationDetail location = data.GetLocation();
			      MonsterDetail monster = data.GetMonster();
			      result = String.format(location.getText(), monster.getName(), monster.getAction());  
			      
			      if (location.isCombat)
			      {
			    	  result += data.TakeDamage();
			      }
			      
			      result += data.GainExperience();
			      
			      result += data.GainCurrency();
 		      }
 		      else
 		      {
 		    	  result = "You do not have enough health to explore.  You should heal yourself.";
 		      }
        }
        
        if (v.getId() == R.id.heal)
        {
        	if (data.spendCurrency(20))
        	{
        	
		      result = "Your health is restored.";  
		      
		      data.FullHeal();
        	}
        	else
        	{
        		result = "You do not have enough money to heal.";
        	}
        }	
        
	    textview.setText(result);
	    health.setText(String.format("Health: %s", data.getHealth()));
	    experience.setText(String.format("Experience: %s", data.getExperience()));
	    currency.setText(String.format("Gold: %s", data.getCurrency()));
   }

}