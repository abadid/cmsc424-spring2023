package com.match.model;

public enum Field {

	Theory, ArtificialIntelligence, Networks, Databases, Security;

	public String toString(){
		switch(this){
			case Theory:
				return "Theory";
			case ArtificialIntelligence:
				return "Artificial Intelligence";
			case Networks:
				return "Networks";
			case Databases:
				return "Databases";
			case Security:
				return "Security";
		}
		return null;
	}

	public static Field fromString(String s){
		switch(s){
			case "Theory":
				return Field.Theory;
			case "Artificial Intelligence":
				return Field.ArtificialIntelligence;
			case "Networks":
				return Field.Networks;
			case "Databases":
				return Field.Databases;
			case "Security":
				return Field.Security;
		}
		return null;
	}
}
