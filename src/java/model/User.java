/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;


public class User {
    
    private String userID,
            email,
            lastName,
            firstName,
            middleIni,
            resClass;
    
    private int age, bal;
    
    private ArrayList<String> lots = new ArrayList<String>();
    private ArrayList<String> cars = new ArrayList<String>();
    
    public User(String userID, String email, String ln, String fn, String mi, String resC, int age, int balance){
        this.userID = userID;
        this.email = email;
        this.lastName = ln;
        this.firstName = fn;
        this.middleIni = mi;
        this.resClass = resC;
        this.bal = balance;
    }
    
    // Setters
        public void setUserID(String id){
            this.userID = id;
        }
        
        public void setEmail(String em) {
            this.email = em;
        }
        
        public void setLastName(String ln) {
            this.lastName = ln;
        }
        
        public void setFirstName(String fn) {
            this.firstName = fn;
        }
    
        public void setMiddleIni(String mi) {
            this.middleIni = mi;
        }
        
        public void setResClass(String rc) {
            this.resClass = rc;
        }
        
        public void setAge(int age) {
            this.age = age;
        }
        
        public void setBal(int bal) {
            this.bal = bal;
        }
        
        public void setLot(ArrayList<String> lots) {
            this.lots = lots;
        }
        
        public void setCars(ArrayList<String> cars) {
            this.cars = cars;
        }
        
    // Add
        public void addLot(String id) {
            this.lots.add(id);
        }
        
        public void addCar(String id) {
            this.cars.add(id);
        }
        
    // Getters
        public String getID() {
            return this.userID;
        }
        
        public String getEmail() {
            return this.email;
        }
        
        public String getLastName() {
            return this.lastName;
        }
        
        public String getFirstName() {
            return this.firstName;
        }
        
        public String getMiddleInitial() {
            return this.middleIni;
        }
        
        public String getResClass() {
            return this.resClass;
        }
        
        public int getAge() {
            return this.age;
        }
        
        public int getBal() {
            return this.bal;
        }
        
        public ArrayList getLots() {
            return this.lots;
        }
        
        public ArrayList getCars() {
            return this.cars;
        }
}
