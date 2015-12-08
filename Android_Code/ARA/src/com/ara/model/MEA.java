package com.ara.model;

public class MEA {
	String Name, Id, Email;

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
	}

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

	public MEA(String Name, String Id,String Email) {

		this.Name = Name;
		this.Id = Id;
		this.Email = Email;

	}

	public MEA() {
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return Name;
	}
}
