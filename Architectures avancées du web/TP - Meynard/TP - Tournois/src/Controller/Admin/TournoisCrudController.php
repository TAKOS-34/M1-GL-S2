<?php

namespace App\Controller\Admin;

use App\Entity\Tournois;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateField;

class TournoisCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Tournois::class;
    }

    
    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            TextField::new('nom', 'Nom du tournoi'),
            DateField::new('dateDeb', 'Date de début'),
            DateField::new('dateFin', 'Date de fin'),
            AssociationField::new('ev', 'Événement'),
        ];
    }
}
