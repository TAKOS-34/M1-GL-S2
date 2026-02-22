<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\Evenement;
use App\Entity\Tournois;
use Symfony\Component\Validator\Constraints\DateTime;

final class MainController extends AbstractController
{

    #[Route("/evt/get", name:"getEvt")]
    public function getEvt(EntityManagerInterface $em): Response {
        $evt = $em->getRepository(Evenement::class)->findall();

        if ($evt == null) {
            return new Response("Pas d'évenements");
        }

        return $this->render('/evenement/getEvenement.twig', [
            'controller_name' => 'getEvenement',
            'evt' => $evt
        ]);
    }

    #[Route("/evt/add/{nom<[0-9a-zA-Z ]+>}/{description<[0-9a-zA-Z ]+>?}", name:"newEvt")]
    public function addEvt($nom, $description, EntityManagerInterface $em): Response {
        $evt = $em->getRepository(Evenement::class)->findOneBy(['nom' => $nom]);

        if ($evt != null) {
            return new Response("Evenement $nom déjà existant");
        }

        $newEvt = new Evenement();
        $newEvt->setNom($nom);
        if ($description != null) {
            $newEvt->setDescription($description);
        }

        $em->persist($newEvt);
        $em->flush();

        return new Response("Evenement $nom à été ajouté");
    }

    #[Route("/tournois/add/{evtId}/{nom<[0-9a-zA-Z ]+>}/{dateDeb}/{dateFin}", name:"newEvt")]
    public function addTournois($evtId, $nom, \DateTime $dateDeb, \DateTime $dateFin, EntityManagerInterface $em): Response {
        $evt = $em->find(Evenement::class, $evtId);

        if ($evt == null) {
            return new Response("Evenement $evtId n'existe pas");
        }

        $newTournois = new Tournois();
        $newTournois->setNom($nom);
        $newTournois->setDateDeb($dateDeb);
        $newTournois->setDateFin($dateFin);
        $newTournois->setEv($evt);

        $em->persist($newTournois);
        $em->flush();

        return new Response("Tounrois $nom à été ajouté");
    }

    #[Route("/tournois/delete/{tournoisId<[0-9]+>}", name:"deleteTournois")]
    public function deleteTournois($tournoisId, EntityManagerInterface $em): Response {
        $tournois = $em->find(Tournois::class, (int) $tournoisId);

        if ($tournois == null) {
            return new Response("Le tournois avec l'id $tournoisId n'existe pas");
        }

        $nom = $tournois->getNom();

        $em->remove($tournois);
        $em->flush();

        return new Response("Tournois $nom à été supprimé");
    }

    #[Route("/evt/delete/{evtId<[0-9]+>}", name:"deleteEvenement")]
    public function deleteEvenement($evtId, EntityManagerInterface $em): Response {
        $evt = $em->find(Evenement::class, (int) $evtId);

        if ($evt == null) {
            return new Response("L'evenement avec l'id $evtId n'existe pas");
        }

        foreach ($evt->getTournoisList() as $tournois) {
            $em->remove($tournois);
        }

        $nom = $evt->getNom();

        $em->remove($evt);
        $em->flush();

        return new Response("Tournois $nom à été supprimé");
    }

    #[Route('/evt/{id}')]
    public function showEvt(Evenement $evt): Response {
        echo($evt);
        return new Response();
    }

    #[Route('/tournois/{id}')]
    public function showTournois(Tournois $tournois): Response {
        echo($tournois);
        return new Response();
    }
}
