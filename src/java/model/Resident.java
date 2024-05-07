package model;

public class Resident extends User {
    private String
            propertyID,
            relationship;
    
    protected UserLot lot;
    
    public Resident(){}
    
    public Resident(String userID, String email, String ln, String fn, String mi, int age, String resClass,
            String propertyID, String relationship){
        super(userID, email, ln, fn, mi, age, resClass);
        this.propertyID = propertyID;
        this.relationship = relationship;
    }
    
    //setters
    
    public void setPropertyID(String propertyID){
        this.propertyID = propertyID;
    }
    
    public void setRelationship(String relationship){
        this.relationship = relationship;
    }
    
    public void setResLot(UserLot lot) {
        this.lot = lot;
    }
    //getters
    
    public String getPropertyID(){
        return this.propertyID;
    }
    
    public String getRelationship(){
        return this.relationship;
    }
    
    public UserLot getResLot() {
        return this.lot;
    }
    
    public String getAddress() {
        return "";
    }
}
