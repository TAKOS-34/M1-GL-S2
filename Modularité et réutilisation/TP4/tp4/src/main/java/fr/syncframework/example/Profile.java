package fr.syncframework.example;

import fr.syncframework.annotation.Sync;
import fr.syncframework.annotation.SyncType;

/**
 * Exemple: classe Profile avec relation ONE_TO_ONE vers User
 */
public class Profile {
    private String bio;
    private String avatarUrl;
    
    @Sync(target = User.class, field = "profile", type = SyncType.ONE_TO_ONE)
    private User user;
    
    public Profile() {
    }
    
    public Profile(String bio) {
        this.bio = bio;
    }
    
    public String getBio() {
        return bio;
    }
    
    public void setBio(String bio) {
        this.bio = bio;
    }
    
    public String getAvatarUrl() {
        return avatarUrl;
    }
    
    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    @Override
    public String toString() {
        return "Profile{bio='" + bio + "', user=" + 
               (user != null ? user.getName() : "null") + "}";
    }
}
