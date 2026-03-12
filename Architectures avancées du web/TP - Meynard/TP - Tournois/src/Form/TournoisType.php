<?php

namespace App\Form;

use App\Entity\Evenement;
use App\Entity\Tournois;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class TournoisType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nom', TextType::class, ['label' => 'Nom'])
            ->add('dateDeb', DateType::class, ['label' => 'Date de début'])
            ->add('dateFin', DateType::class, ['label' => 'Date de fin'])
            ->add('ev', EntityType::class, [
                'class' => Evenement::class,
                'choice_label' => 'nom',
                'label' => 'Evenement associé'
            ])
            ->add('sauver', SubmitType::class, ['label' => 'Créer le tournoi'])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Tournois::class,
        ]);
    }
}
