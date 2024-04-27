package model;

public class Vehicle {
    private String vehicleID,
            userID,
            type,
            plateNo,
            brand,
            model,
            lastName,
            firstName,
            middleInitial;
    
    public Vehicle(){}
    
    public Vehicle(String vehicleID, String userID, String type, String plateNo, String brand, String model, String lastName, String firstName, String middleInitial){
        this.vehicleID = vehicleID;
        this.userID = userID;
        this.type = type;
        this.plateNo = plateNo;
        this.brand = brand;
        this.model = model;
        this.lastName = lastName;
        this.firstName = firstName;
        this.middleInitial = middleInitial;
    }
    
    //setters
    public void setVehicleID(String vehicleID){
        this.vehicleID = vehicleID;
    }
    
    public void setSserID(String userID){
        this.userID = userID;
    }
    
    public void setType(String type){
        this.type = type;
    }
    
    public void setPlateNo(String plateNo){
        this.plateNo = plateNo;
    }
    
    public void setBrand(String vehicleID){
        this.vehicleID = vehicleID;
    }
    
    public void setModel(String model){
        this.model = model;
    }
    
    public void setLastName(String lastName){
        this.lastName = lastName;
    }
    
    public void setFirstName(String firstName){
        this.firstName = firstName;
    }
    
    public void setMiddleInitial(String middleInitial){
        this.middleInitial = middleInitial;
    }
    
    //getters
    public String getVehicleID(){
        return this.vehicleID;
    }
    
    public String getSserID(){
        return this.userID;
    }
    
    public String getType(){
        return this.type;
    }
    
    public String getPlateNo(){
        return this.plateNo;
    }
    
    public String getBrand(){
        return this.vehicleID;
    }
    
    public String getModel(){
        return this.model;
    }
    
    public String getLastName(){
        return this.lastName;
    }
    
    public String getFirstName(){
        return this.firstName;
    }
    
    public String setMiddleInitial(){
        return this.middleInitial;
    }
}
