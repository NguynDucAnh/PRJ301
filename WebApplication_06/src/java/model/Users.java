/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author user
 */
public class Users {
 private String userID;
 private String fullname;
 private String address;
 private String phone;
 private String taxUD;

    public Users() {
    }

    public Users(String userID, String fullname, String address, String phone, String taxUD) {
        this.userID = userID;
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.taxUD = taxUD;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getTaxUD() {
        return taxUD;
    }

    public void setTaxUD(String taxUD) {
        this.taxUD = taxUD;
    }
 
 
}
