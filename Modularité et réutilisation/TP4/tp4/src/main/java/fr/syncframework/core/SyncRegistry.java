package fr.syncframework.core;
import fr.syncframework.annotation.Sync;
import fr.syncframework.annotation.SyncType;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;

public class SyncRegistry {
    private static SyncRegistry instance = null;
    private static HashMap<Class<?>, ArrayList<SyncMetadata>> registry = new HashMap<>();

    private SyncRegistry() {}

    public static synchronized SyncRegistry getInstance() {
        if (instance == null) instance = new SyncRegistry();

        return instance;
    }

    public static void register(Class<?> classe) {
        ArrayList<SyncMetadata> list = new ArrayList<>();

        for (Field f : classe.getDeclaredFields()) {
            if (f.isAnnotationPresent(Sync.class)) {
                Sync annotation = f.getAnnotation(Sync.class);

                SyncMetadata newMetadata = new SyncMetadata(annotation.target(), annotation.field(), annotation.type());
                list.add(newMetadata);
            }
        }

        registry.put(classe, list);
    }

    public static void validate(Class<?> classe) {
        ArrayList<SyncMetadata> metaDataList = registry.get(classe);

        if (metaDataList == null) throw new RuntimeException("No class found");

        for (SyncMetadata metaData : metaDataList) {
            for (SyncMetadata metaDataTarget : registry.get(metaData.target())) {
                try {
                    if (classe.getDeclaredField(metaData.field()).toString().equals(metaData.field())) {
                        if (metaDataTarget.target().equals(classe)) {
                            if (compareSync(metaData.type(), metaDataTarget.type())) {
                                break;
                            } else {
                                throw new RuntimeException("Sync type isn't matching");
                            }
                        } else {
                            throw new RuntimeException("Class target isn't matching");
                        }
                    } else {
                        throw new RuntimeException("Class field isn't matching");
                    }
                } catch (NoSuchFieldException e) {
                    throw new RuntimeException("No existing field matching");
                }
            }
        }
    }

    public static void initialize(Class<?>... classes) {
        for (Class<?> c : classes) {
            initialize(c);
        }
        for (Class<?> c : classes) {
            validate(c);
        }
    }

    public static boolean compareSync(SyncType syncType, SyncType syncTypeTarget) {
        switch (syncType) {
            case ONE_TO_MANY: return syncTypeTarget == SyncType.MANY_TO_ONE;
            case MANY_TO_ONE: return syncTypeTarget == SyncType.ONE_TO_MANY;
            case ONE_TO_ONE: return syncTypeTarget == SyncType.ONE_TO_ONE;
            case MANY_TO_MANY: return syncTypeTarget == SyncType.MANY_TO_MANY;
        }
        return false;
    }
}
