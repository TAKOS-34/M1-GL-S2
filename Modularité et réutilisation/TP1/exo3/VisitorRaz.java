public class VisitorRaz extends Visitor {
    public VisitorRaz() {}

    public void visit(EltStockage e) {
        System.out.println("fail");
    }

    public void visitFichier(Fichier e) {
        e.clean();
    }

    public void visitLien(Lien l) {}
}
