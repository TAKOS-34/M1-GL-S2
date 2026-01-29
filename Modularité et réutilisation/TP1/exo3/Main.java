public class Main {
    public static void main(String[] args) {
        try {
            Repertoire r = new Repertoire();
            Fichier file = new Fichier("test", r, "qeifiqefoqehfiqeohifo");
            System.out.println(file.cat());
            VisitorRaz vr = new VisitorRaz();
            file.accept(vr);
            System.out.println(file.cat());
        } catch (Exception e) {
            System.err.println("Une erreur inattendue est survenue : ");
            e.printStackTrace();
        }
    }
}