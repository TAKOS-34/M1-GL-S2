<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;
use App\Utils\Mastermind;

final class MastermindController extends AbstractController
{
    #[Route('/mastermind', name: 'mastermindMain', methods: ['GET'])]
    public function mastermind(Request $request): Response
    {
        $session = $request->getSession();
        $mastermind;

        if ($session->has('mastermind')) {
            $mastermind = $session->get('mastermind');
            $code = $request->query->get('code');

            if ($code && !$mastermind->isFini()) {
                $mastermind->test($code);
            }
        } else {
            $mastermind = new Mastermind;
        }

        $session->set('mastermind', $mastermind);

        return $this->render('mastermind/index.html.twig', [
            'controller_name' => 'MastermindController',
            'mastermind' => $mastermind
        ]);
    }

    #[Route('/mastermind', name: 'mastermindReset', methods: ['POST'])]
    public function mastermindReset(Request $request): Response
    {
        $session = $request->getSession();
        $mastermind = new Mastermind;
        $session->set('mastermind', $mastermind);

        return $this->redirectToRoute('mastermindMain');
    }
}
