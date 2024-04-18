<?php

namespace App\Controller;

use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class UserController extends AbstractController
{
    #[Route('/user', name: 'app_user',methods: ['POST'])]
    public function addUser(EntityManagerInterface $em): Response
    {
        $user = new User();
        $user->setUsername('testuser');
        $user->setEmail('test@example.com');
        $user->setPassword('securepassword'); // You should hash this in a real app

        $em->persist($user);
        $em->flush();

        return new Response('User added with id ' . $user->getId());
    }
}
