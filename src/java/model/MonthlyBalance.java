/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Joseph Robles
 */
public class MonthlyBalance {
    
    protected String propertyID;
    protected Date balanceDate;
    protected double balance;
    
    public MonthlyBalance(String propId, Date balDate, double bal){
        this.propertyID = propId;
        this.balanceDate = balDate;
        this.balance = bal;
    }
    
    //Setter
    
    public void setPropertyID(String propId){
        this.propertyID = propId;
    }
    
    public void setBalanceDate(Date balDate){
        this.balanceDate = balDate;
    }
    
    public void setBalance(double bal){
        this.balance = bal;
    }
    
    //getters
    
    public String getPropertyID(){
        return this.propertyID;
    }
    
    public Date getBalanceDate(){
        return this.balanceDate;
    }
    
    public double getBalance(){
        return this.balance;
    }
}
