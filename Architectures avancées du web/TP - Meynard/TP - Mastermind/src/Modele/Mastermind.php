<?php

namespace App\Utils;

interface IMastermind {
    public function __construct();
    public function test($code);
    public function getEssais();
    public function getTaille(); 
    public function isFini();
}

class Mastermind implements IMastermind {
    protected $res = [];
    public $essais = [];
    protected int $taille = 4;
    protected int $bienPlaces = 0;
    protected int $malPlaces = 0;
    protected int $nbEssais = 0;
    protected bool $isFini = false;

    public function __construct() {
        for ($i = 0; $i < $this->taille; $i++) {
            array_push($this->res, rand(0, 9));
        }
    }

    public function test($code) {
        $code_str = str_split($code);
        $bienPlace = 0;
        $malPlace = 0;

        for ($i = 0; $i < $this->taille; $i++) {
            $isEnd = true;
            if ($code_str[$i] == $this->res[$i]) {
                $bienPlace++;
            } else {
                $isEnd = false;
            }
        }

        if ($isEnd) {
            $this->isFini = true;
        }

        for ($i = 0; $i < $this->taille; $i++) {
            if (in_array($code_str[$i], $this->res) && ($code_str[$i] != $this->res[$i])) {
                $malPlace++;
            }
        }

        $this->bienPlaces = $bienPlace;
        $this->malPlaces = $malPlace;
        $this->nbEssais++;
        array_push($this->essais, ['code' => $code, 'bien' => $bienPlace, 'mal' => $malPlace]);
    }

    public function getEssais() {
        return $this->nbEssais;
    }

    public function getTaille() {
        return $this->taille;
    }

    public function isFini() {
        return $this->isFini;
    }
}