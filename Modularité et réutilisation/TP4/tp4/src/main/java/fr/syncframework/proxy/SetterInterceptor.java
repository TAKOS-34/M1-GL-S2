package fr.syncframework.proxy;
import net.bytebuddy.implementation.bind.annotation.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.concurrent.Callable;

public class SetterInterceptor {
    @RuntimeType
    public static Object intercept(@This Object obj, @Origin Method method, @AllArguments Object[] args, @SuperCall Callable<?> zuper) throws Exception {
        String nomMethode = method.getName();

        if (nomMethode.length() > 3) {
            nomMethode = nomMethode.toLowerCase().substring(3);
        } else {
            return zuper.call();
        }

        Field field = obj.getClass().getSuperclass().getDeclaredField(nomMethode);
        field.setAccessible(true);
        Object ancienneValeur = field.get(obj);

        Object resultat = zuper.call();
        Object nouvelleValeur = args[0];

        return resultat;
    }
}
