<?php

namespace App\Controller;

use App\Utils\MathUtils;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class Combinatoire extends AbstractController {
    #[Route('/combi/{n}/{p}', name: 'combi')]
    public function combi($n, $p): Response
    {
        $nFact = MathUtils::mFact((int) $n);
        $pFact = MathUtils::mFact((int) $p);
        $nmoinspFact = MathUtils::mFact((int) $n - (int) $p);

        return new Response(
            '<html><body>'.($nFact / ($pFact * $nmoinspFact)).'</body></html>'
        );
    }
}