package model;

public class Homeowner extends User{
    private String hoID,
            mobNo,
            landNo,
            representative,
            repMobNo,
            houseNo,
            street,
            village,
            barangay,
            city,
            province,
            orNum;
    
    public Homeowner(){}
    
    public Homeowner(String userID, String email, String ln, String fn, String mi, int age, String resClass,
            String mobNo, String landNo, String representative, String repMobNo, String houseNo, String street, String village, String barangay, 
            String city, String province, String orNum){
        super(userID, email, ln, fn, mi, age, resClass);
        this.mobNo = mobNo;
        this.landNo = landNo;
        this.representative = representative;
        this.repMobNo = repMobNo;
        this.houseNo = houseNo;
        this.street = street;
        this.village = village;
        this.barangay = barangay;
        this.city = city;
        this.province = province;
        this.orNum = orNum;
    }
    
    //setters
    public void setHoID(String hoID){
        this.hoID = hoID;
    }
    
    public void setMobNo(String mobNo){
        this.mobNo = mobNo;
    }
    
    public void setLandNo(String landNo){
        this.landNo = landNo;
    }
    
    public void setRepresentative(String representative){
        this.representative = representative;
    }
    
    public void setRepMobNo(String repMobNo){
        this.repMobNo = repMobNo;
    }
    
    public void setHouseNo(String houseNo){
        this.houseNo = houseNo;
    }
    
    public void setStreet(String street){
        this.street = street;
    }
    
    public void setVillage(String village){
        this.village = village;
    }
    
    public void setBarangay(String barangay){
        this.barangay = barangay;
    }
    
    public void setCity(String city){
        this.city = city;
    }
    
    public void setProvince(String province){
        this.province = province;
    }
    
    public void sethoID(String hoID){
        this.hoID = hoID;
    }
    
    public void setOrNum(String orNum){
        this.orNum = orNum;
    }
    
    
    //getters
    public String getHoID(){
        return this.hoID;
    }
    
    public String getMobNo(){
        return this.mobNo;
    }
    
    public String getLandNo(){
        return this.landNo;
    }
    
    public String getRepresentative(){
        return this.representative;
    }
    
    public String getRepMobNo(){
        return this.repMobNo;
    }
    
    public String setHouseNo(){
        return this.houseNo;
    }
    
    public String getStreet(){
        return this.street;
    }
    
    public String getVillage(){
        return this.village;
    }
    
    public String getBarangay(){
        return this.barangay;
    }
    
    public String getCity(){
        return this.city;
    }
    
    public String SetProvince(){
        return this.province;
    }
    
    public String getHoID(String hoID){
        return this.hoID;
    }
    
    public String SetOrNum(String orNum){
        return this.orNum;
    }
}
