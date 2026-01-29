<?php

namespace App\Controller;

use App\Utils\MathUtils;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;

final class BaseController extends AbstractController
{
    #[Route('/')]
    public function index(Request $request): Response {
        $n_facto = $request->query->get('facto');

        $n_combi = $request->query->get('n_combi');
        $p_combi = $request->query->get('p_combi');

        if (isset($n_facto)) {
            $res = MathUtils::mFact((int) $n_facto);
            $type = "facto";

            return $this->render('base/index.html.twig', [
                'res' => $res,
                'n_facto' => $n_facto
            ]);
        } else if (isset($n_combi) && isset($p_combi)) {
            $nFact = MathUtils::mFact((int) $n_combi);
            $pFact = MathUtils::mFact((int) $p_combi);
            $nmoinspFact = MathUtils::mFact((int) $n_combi - (int) $p_combi);

            $res = $nFact / ($pFact * $nmoinspFact);

            return $this->render('base/index.html.twig', [
                'res' => $res,
                'n_combi' => $n_combi,
                'p_combi' => $p_combi
            ]);
        } else {
            return $this->render('base/index.html.twig');
        }
    }
}
