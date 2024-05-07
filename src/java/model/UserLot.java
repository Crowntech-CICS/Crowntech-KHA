package model;
import java.util.Date;

public class UserLot {
    private String propertyID,
            titleNo,
            lastName,
            firstName,
            middleInitial,
            houseNo,
            street,
            barangay,
            area,
            surveyNo, 
            lotNo,
            use,
            businessName,
            businessType,
            taxDecNo,
            propIndexNo;
    
    private float balance;
    private Date dateRegistered, paymentDate;
    
    public UserLot(){}
    
    public UserLot(String propertyID, String titleNo, String lastName, String firstName, String middleInitial, String houseNo, String street, 
            String barangay, String area, String surveyNo, String lotNo, Date dateRegistered, float balance, String use, String businessName, String businessType,
             Date paymentDate, String taxDecNo,  String propIndexNo){
        this.propertyID = propertyID;
        this.titleNo = titleNo;
        this.lastName = lastName;
        this.firstName = firstName;
        this.middleInitial = middleInitial;
        this.houseNo = houseNo;
        this.street = street;
        this.barangay = barangay;
        this.area = area;
        this.surveyNo = surveyNo;
        this.lotNo = lotNo;
        this.dateRegistered = dateRegistered;
        this.balance = balance;
        this.use = use;
        this.businessName = businessName;
        this.businessType = businessType;
        this.paymentDate = paymentDate;
        this.taxDecNo = taxDecNo;
        this.propIndexNo = propIndexNo;
    }
    
    //setters
    public void setPropertyID(String propertyID){
        this.propertyID = propertyID;
    }
    
    public void setTitleNo(String titleNo){
        this.titleNo = titleNo;
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
    
    public void setHouseNo(String houseNo){
        this.houseNo = houseNo;
    }
    
    public void setStreet(String street){
        this.street = street;
    }
    
    public void setBarangay(String barangay){
        this.barangay = barangay;
    }
    
    public void setArea(String area){
        this.area = area;
    }
    
    public void setSurveyNo(String surveyNo){
        this.surveyNo = surveyNo;
    }
    
    public void setLotNo(String lotNo){
        this.lotNo = lotNo;
    }
    
    public void setDateRegistered(Date dateRegistered){
        this.dateRegistered = dateRegistered;
    }
    
    public void setBalance(float balance){
        this.balance = balance;
    }
    
    public void setUse(String use){
        this.use = use;
    }
    
    public void setBusinessName(String businessName){
        this.businessName = businessName;
    }
    
    public void setBusinessType(String businessType){
        this.businessType = businessType;
    }
    
    public void setPaymentDate(Date paymentDate){
        this.paymentDate = paymentDate;
    }
    
    public void setTaxDecNo(String taxDecNo){
        this.taxDecNo = taxDecNo;
    }
    
    public void setPropIndexNo(String propIndexNo){
        this.propIndexNo = propIndexNo;
    }
    
    //getters
    public String getPropertyID(){
        return this.propertyID;
    }
    
    public String getTitleNo(){
        return this.titleNo;
    }
    
    public String getLastName(){
        return this.lastName;
    }
    
    public String getFirstName(){
        return this.firstName;
    }
    
    public String getMiddleInitial(){
        return this.middleInitial;
    }
    
    public String getHouseNo(){
        return this.houseNo;
    }
    
    public String getStreet(){
        return this.street;
    }
    
    public String getBarangay(){
        return this.barangay;
    }
    
    public String getArea(){
        return this.area;
    }
    
    public String getSurveyNo(){
        return this.surveyNo;
    }
    
    public String getLotNo(){
        return this.lotNo;
    }
    
    public Date getDateRegistered(){
        return this.dateRegistered;
    }
    
    public float getBalance(){
        return this.balance;
    }
    
    public String getUse(){
        return this.use;
    }
    
    public String getBusinessName(){
        return this.businessName;
    }
    
    public String getBusinessType(){
        return this.businessType;
    }
    
    public Date getPaymentDate(){
        return this.paymentDate;
    }
    
    public String setTaxDecNo(){
        return this.taxDecNo;
    }
    
    public String setPropIndexNo(){
        return this.propIndexNo;
    }
}
