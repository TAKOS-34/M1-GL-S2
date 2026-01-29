<?php

namespace App\Utils;

class MathUtils {
    public static function mFact(int $n): int {
        $res = 1;

        for ($i = 1; $i <= $n; $i++) {
            $res *= $i;
        }

        return $res;
    }
}