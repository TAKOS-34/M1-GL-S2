<?php

namespace App\Entity;

use App\Repository\EvenementRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: EvenementRepository::class)]
class Evenement
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 30)]
    #[Assert\NotBlank]
    #[Assert\Length(min: 4)]
    private string $nom;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $description = null;

    /**
     * @var Collection<int, Tournois>
     */
    #[ORM\OneToMany(targetEntity: Tournois::class, mappedBy: 'ev', orphanRemoval: true)]
    private Collection $tournois_list;

    public function __construct()
    {
        $this->tournois_list = new ArrayCollection();
    }

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

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): static
    {
        $this->description = $description;

        return $this;
    }

    /**
     * @return Collection<int, Tournois>
     */
    public function getTournoisList(): Collection
    {
        return $this->tournois_list;
    }

    public function addTournoisList(Tournois $tournoisList): static
    {
        if (!$this->tournois_list->contains($tournoisList)) {
            $this->tournois_list->add($tournoisList);
            $tournoisList->setEv($this);
        }

        return $this;
    }

    public function removeTournoisList(Tournois $tournoisList): static
    {
        if ($this->tournois_list->removeElement($tournoisList)) {
            // set the owning side to null (unless already changed)
            if ($tournoisList->getEv() === $this) {
                $tournoisList->setEv(null);
            }
        }

        return $this;
    }

    public function __toString(): string
    {
        return sprintf(
            "ID: %d - Nom: %s - Description: %s",
            $this->getId(),
            $this->getNom(),
            $this->getDescription()
        );
    }
}
