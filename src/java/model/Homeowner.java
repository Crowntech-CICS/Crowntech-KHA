/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ejlu1
 */
public class Homeowner extends User {
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
}
