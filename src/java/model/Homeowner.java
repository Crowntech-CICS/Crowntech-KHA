package model;

public class Homeowner extends User{
    private String mobNo,
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

    /**
     * @return the mobNo
     */
    public String getMobNo() {
        return mobNo;
    }

    /**
     * @param mobNo the mobNo to set
     */
    public void setMobNo(String mobNo) {
        this.mobNo = mobNo;
    }

    /**
     * @return the landNo
     */
    public String getLandNo() {
        return landNo;
    }

    /**
     * @param landNo the landNo to set
     */
    public void setLandNo(String landNo) {
        this.landNo = landNo;
    }

    /**
     * @return the representative
     */
    public String getRepresentative() {
        return representative;
    }

    /**
     * @param representative the representative to set
     */
    public void setRepresentative(String representative) {
        this.representative = representative;
    }

    /**
     * @return the repMobNo
     */
    public String getRepMobNo() {
        return repMobNo;
    }

    /**
     * @param repMobNo the repMobNo to set
     */
    public void setRepMobNo(String repMobNo) {
        this.repMobNo = repMobNo;
    }

    /**
     * @return the houseNo
     */
    public String getHouseNo() {
        return houseNo;
    }

    /**
     * @param houseNo the houseNo to set
     */
    public void setHouseNo(String houseNo) {
        this.houseNo = houseNo;
    }

    /**
     * @return the street
     */
    public String getStreet() {
        return street;
    }

    /**
     * @param street the street to set
     */
    public void setStreet(String street) {
        this.street = street;
    }

    /**
     * @return the village
     */
    public String getVillage() {
        return village;
    }

    /**
     * @param village the village to set
     */
    public void setVillage(String village) {
        this.village = village;
    }

    /**
     * @return the barangay
     */
    public String getBarangay() {
        return barangay;
    }

    /**
     * @param barangay the barangay to set
     */
    public void setBarangay(String barangay) {
        this.barangay = barangay;
    }

    /**
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * @return the province
     */
    public String getProvince() {
        return province;
    }

    /**
     * @param province the province to set
     */
    public void setProvince(String province) {
        this.province = province;
    }

    /**
     * @return the orNum
     */
    public String getOrNum() {
        return orNum;
    }

    /**
     * @param orNum the orNum to set
     */
    public void setOrNum(String orNum) {
        this.orNum = orNum;
    }
    
    
}
