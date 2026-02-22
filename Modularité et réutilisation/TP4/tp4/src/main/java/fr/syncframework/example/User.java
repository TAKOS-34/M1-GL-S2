package fr.syncframework.example;

import fr.syncframework.annotation.Sync;
import fr.syncframework.annotation.SyncType;

import java.util.ArrayList;
import java.util.List;

/**
 * Exemple: classe User avec relation bidirectionnelle vers Order
 */
public class User {
    private String name;
    
    @Sync(target = Order.class, field = "customer", type = SyncType.ONE_TO_MANY)
    private List<Order> orders = new ArrayList<>();
    
    @Sync(target = Profile.class, field = "user", type = SyncType.ONE_TO_ONE)
    private Profile profile;
    
    public User() {
    }
    
    public User(String name) {
        this.name = name;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public List<Order> getOrders() {
        return orders;
    }
    
    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }
    
    public Profile getProfile() {
        return profile;
    }
    
    public void setProfile(Profile profile) {
        this.profile = profile;
    }
    
    @Override
    public String toString() {
        return "User{name='" + name + "', orders=" + orders.size() + 
               ", profile=" + (profile != null ? profile.getBio() : "null") + "}";
    }
}
