/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import model.User;

/**
 *
 * @author ejlu1
 */
public class Homeowner extends User{
    private String hoID,
            mobNo,
            landNo,
            houseNo,
            street,
            village,
            barangay,
            city,
            province,
            ornum;
    
    public Homeowner(String hoid, String mobile, String land, String st, String vil, String bar, String city, String prov, String ornum){
        this.hoID = hoid;
        this.mobNo = mobile;
        this.landNo = land;
        this.street = st;
        this.village = vil;
        this.barangay = bar;
        this.city = city;
        this.province = prov;
        this.ornum = ornum;
    }
    public Homeowner(String userID, String email, String ln, String fn, String mi, String resC, int age, int balance, String hoid, String mobile, String land, String st, String vil, String bar, String city, String prov, String ornum){
        super(userID, email, lastName, firstName, middleIni, resClass);
        this.userID = userID;
        this.email = email;
        this.lastName = ln;
        this.hoID = hoid;
        this.mobNo = mobile;
        this.landNo = land;
        this.street = st;
        this.village = vil;
        this.barangay = bar;
        this.city = city;
        this.province = prov;
        this.ornum = ornum;
    }
    
    
    
}
