package com.prekog.adventure;

public class LocationDetail {

	private String text;
	public Boolean isCombat;
	
	public LocationDetail(String p, Boolean combat) {
		setText(p);
		isCombat = combat;
	}
	
	public void setText(String p) {text=p;}
	public String getText() { return text;}
}
