<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use ApiPlatform\Metadata\GetCollection;
use Symfony\Component\Serializer\Attribute\Groups;
use App\Repository\TournoisRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: TournoisRepository::class)]
#[ApiResource(
    operations: [
        new GetCollection()
    ],
    normalizationContext: ['groups' => ['tournois:read']],
    denormalizationContext: ['groups' => ['tournois:write']]
)]
class Tournois
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(['tournois:read', 'evenement:read'])]
    private ?int $id = null;

    #[ORM\Column(length: 30)]
    #[Assert\NotBlank]
    #[Groups(['tournois:read', 'tournois:write', 'evenement:read'])]
    private string $nom;

    #[ORM\Column(type: Types::DATE_MUTABLE)]
    #[Assert\NotBlank]
    #[Assert\DateTime]
    #[Groups(['tournois:read', 'tournois:write', 'evenement:read'])]
    private \DateTime $dateDeb;

    #[ORM\Column(type: Types::DATE_MUTABLE)]
    #[Assert\NotBlank]
    #[Assert\DateTime]
    #[Groups(['tournois:read', 'tournois:write', 'evenement:read'])]
    private \DateTime $dateFin;

    #[ORM\ManyToOne(inversedBy: 'tournois_list')]
    #[ORM\JoinColumn(nullable: false)]
    #[Assert\NotBlank]
    #[Groups(['tournois:read', 'tournois:write'])]
    private Evenement $ev;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): static
    {
        $this->nom = $nom;

        return $this;
    }

    public function getDateDeb(): ?\DateTime
    {
        return $this->dateDeb;
    }

    public function setDateDeb(\DateTime $dateDeb): static
    {
        $this->dateDeb = $dateDeb;

        return $this;
    }

    public function getDateFin(): ?\DateTime
    {
        return $this->dateFin;
    }

    public function setDateFin(\DateTime $dateFin): static
    {
        $this->dateFin = $dateFin;

        return $this;
    }

    public function getEv(): ?Evenement
    {
        return $this->ev;
    }

    public function setEv(?Evenement $ev): static
    {
        $this->ev = $ev;

        return $this;
    }

    public function __toString(): string
    {
        return sprintf(
            "ID: %d - Nom: %s - Date debut: %s - Date fin: %s",
            $this->getId(),
            $this->getNom(),
            $this->getDateDeb()->format('d/m/Y'),
            $this->getDateFin()->format('d/m/Y')
        );
    }
}
