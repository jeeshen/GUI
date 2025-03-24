package main;

import java.io.Serializable;

public class UserInfo implements Serializable {
    private String name;
    private String phoneNumber;
    private String address;

    public UserInfo() {}

    public UserInfo(String name, String phoneNumber, String address) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getString() {
        return "Name: " + name + ", Email: " + phoneNumber + ", Address: " + address;
    }
}
