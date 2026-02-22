package fr.syncframework;
import fr.syncframework.core.SyncRegistry;
import fr.syncframework.example.Order;

public class Main {
    public static void main() {
        Order o = new Order();
        SyncRegistry s = SyncRegistry.getInstance();

        s.register(Order.class);
    }
}
