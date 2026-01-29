public class Fichier extends ElementAtomique implements Element {
    protected String contenue;

    public Fichier(String nom, Repertoire parent, String contenue) {
        super(nom, parent);
        this.contenue = contenue;
    }

    @Override
    public int nbElement() {
        return (int) contenue.chars()
                .filter(c -> c == ' ')
                .count();
    }

    @Override
    public int size() {
        return getBasicSize() + contenue.length();
    }

    public String cat() {
        return contenue;
    }

    public void clean() {
        this.contenue = "";
    }

    public void accept(Visitor v) {
        v.visitFichier(this);
    }
}