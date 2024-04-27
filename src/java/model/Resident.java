package model;

public class Resident extends User {
    private String residentID,
            propertyID,
            relationship;
    
    public Resident(){}
    
    public Resident(String userID, String email, String pass, String ln, String fn, String mi, int age, String resClass,
            String residentID, String propertyID, String relationship){
        super(userID, email, pass, ln, fn, mi, age, resClass);
        this.residentID = residentID;
        this.propertyID = propertyID;
        this.relationship = relationship;
    }
    
    //setters
    public void setResidentID(String residentID){
        this.residentID = residentID;
    }
    
    public void setPropertyID(String propertyID){
        this.propertyID = propertyID;
    }
    
    public void setRelationship(String relationship){
        this.relationship = relationship;
    }
    
    //getters
    public String getResidentID(){
        return this.residentID;
    }
    
    public String getPropertyID(){
        return this.propertyID;
    }
    
    public String getRelationship(){
        return this.relationship;
    }
}
