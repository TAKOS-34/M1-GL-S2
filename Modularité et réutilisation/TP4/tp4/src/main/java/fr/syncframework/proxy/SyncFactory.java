package fr.syncframework.proxy;
import fr.syncframework.core.SyncRegistry;
import net.bytebuddy.ByteBuddy;
import net.bytebuddy.implementation.MethodDelegation;
import net.bytebuddy.matcher.ElementMatchers;
import java.lang.reflect.InvocationTargetException;
import static net.bytebuddy.matcher.ElementMatchers.takesArguments;

public class SyncFactory {
    public static <T> T create(Class<T> clazz) throws NoSuchMethodException, InvocationTargetException, InstantiationException, IllegalAccessException {
        SyncRegistry.register(clazz);

        Class<? extends T> poxyClass = new ByteBuddy()
                .subclass(clazz)
                .method(ElementMatchers.nameStartsWith("set").and(takesArguments(1)))
                .intercept(MethodDelegation.to(new SetterInterceptor()))
                .make()
                .load(clazz.getClassLoader())
                .getLoaded();

        return poxyClass.getDeclaredConstructor().newInstance();
    }
}
