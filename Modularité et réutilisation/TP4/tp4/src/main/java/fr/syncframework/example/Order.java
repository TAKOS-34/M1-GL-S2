package fr.syncframework.example;

import fr.syncframework.annotation.Sync;
import fr.syncframework.annotation.SyncType;

/**
 * Exemple: classe Order avec relation bidirectionnelle vers User
 */
public class Order {
    private String description;
    private double amount;
    
    @Sync(target = User.class, field = "orders", type = SyncType.MANY_TO_ONE)
    private User customer;
    
    public Order() {
    }
    
    public Order(String description, double amount) {
        this.description = description;
        this.amount = amount;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    public User getCustomer() {
        return customer;
    }
    
    public void setCustomer(User customer) {
        this.customer = customer;
    }
    
    @Override
    public String toString() {
        return "Order{description='" + description + "', amount=" + amount + 
               ", customer=" + (customer != null ? customer.getName() : "null") + "}";
    }
}
