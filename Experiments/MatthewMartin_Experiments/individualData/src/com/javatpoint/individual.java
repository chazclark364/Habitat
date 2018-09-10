package com.javatpoint;

public class individual {

    private String tenantName;

    public String getTenantName(){
        return tenantName;
    }

    public void setTenantName(String name){
        this.tenantName = name;
    }

    public void displayInfo(){
        System.out.println("Hello: " + tenantName);
    }
}
