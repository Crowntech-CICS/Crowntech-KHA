package model;

import java.util.ArrayList;

public class User {

    protected String userID,
            email,
            pass,
            lastName,
            firstName,
            middleIni,
            resClass;

    protected int age;

    protected ArrayList<UserLot> lots = new ArrayList<>(); 
    protected ArrayList<Vehicle> cars = new ArrayList<>(); 
    
//    protected ArrayList<String> lots = new ArrayList<>(); 
//    protected ArrayList<String> cars = new ArrayList<>(); 

    public User() {
    }

    public User(String userID, String email, String pass, String ln, String fn, String mi, int age, String resClass) {
        this.userID = userID;
        this.email = email;
        this.pass = pass;
        this.lastName = ln;
        this.firstName = fn;
        this.middleIni = mi;
        this.age = age;
        this.resClass = resClass;
    }

    // Setters
    public void setUserID(String id) {
        this.userID = id;
    }

    public void setEmail(String em) {
        this.email = em;
    }

    public void setPass(String pass) {
        this.pass = pass;
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

//        public void setBal(int bal) {
//            this.bal = bal;
//        }
    
    public void setLot(ArrayList<UserLot> lots) {
        this.lots = lots;
    }

    public void setCars(ArrayList<Vehicle> cars) {
        this.cars = cars;
    }
    
//    public void setLot(ArrayList<String> lots) {
//        this.lots = lots;
//    }
//
//    public void setCars(ArrayList<String> cars) {
//        this.cars = cars;
//    }

    // Add
    public void addLot(UserLot lot) {
        this.lots.add(lot);
    }

    public void addCar(Vehicle vehicle) {
        this.cars.add(vehicle);
    }

//        public void addLot(String id) {
//            this.lots.add(id);
//        }
//        
//        public void addCar(String id) {
//            this.cars.add(id);
//        }
    
    // Getters
    public String getID() {
        return this.userID;
    }

    public String getEmail() {
        return this.email;
    }

    public String getPass() {
        return this.pass;
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

//        public int getBal() {
//            return this.bal;
//        }
    public ArrayList getLots() {
        return this.lots;
    }

    public ArrayList getCars() {
        return this.cars;
    }
}
