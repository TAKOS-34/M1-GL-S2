package fr.syncframework.core;
import fr.syncframework.annotation.SyncType;

public class SyncMetadata {
    private Class<?> classe;
    private String field;
    private SyncType type;

    public SyncMetadata(Class<?> classe, String field, SyncType type) {
        this.classe = classe;
        this.field = field;
        this.type = type;
    }

    public Class<?> target() {
        return classe;
    }

    public String field() {
        return field;
    }

    public SyncType type() {
        return type;
    }
}
