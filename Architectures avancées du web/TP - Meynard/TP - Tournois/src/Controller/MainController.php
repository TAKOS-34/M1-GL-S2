<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class MainController extends AbstractController
{
    #[Route('/main', name: 'app_main')]
    public function index(): Response
    {
        return $this->render('main/index.html.twig', [
            'controller_name' => 'MainController',
        ]);
    }

    #[Route("/tournoi/newEvt/{nom<[0-9a-zA-Z ]+>}", name:"newEvt")]
    public function newEvt($nom, EntityManagerInterface $em): Response {
        $evt = $em->find("App\Entity\Evenement", $nom);

        if ($evt != null) {
            return new Response("Evenement $nom déjà existant");
        }

        $newEvt = new Evenement();
        $newEvt->setNom($nom);
    }
}
