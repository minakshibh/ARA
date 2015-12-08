package com.ara.model;

public class Role {
	String Name, Id;

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}

	public Role(String Name, String Id) {
		super();
		this.Name = Name;
		this.Id = Id;

	}

	public Role() {
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return Name;
	}
}
