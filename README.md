# The endless deck

**[Jugar en el navegador](https://md6-0.github.io/The-endless-deck/)**: con teclado (WASD o flechas) o con mando.

Juego estilo endless runner horizontal en 2D con  estética 1 bit.

En este juego, tomas el control de un personaje que se desplaza automáticamente y cuenta con un sistema de control basado en cartas, que asigna acciones a los botones del mando de manera dinámica y aleatoria.


## Características

Al inicio de cada nivel, los botones A, B, X e Y de tu mando están asignados a diferentes acciones (p. ej., salto, disparo, dash). Cada vez que usas uno de estos botones, la acción se reasigna aleatoriamente entre las disponibles en tu baraja.

A medida que avanzas en el juego, puedes ganar monedas para comprar nuevas cartas que añadirán más variedad y estrategia a tu baraja.


## Objetivos del Juego

Avanza lo más lejos posible en un entorno interminable lleno de obstáculos y enemigos.

Usa tus cartas estratégicamente para superar desafíos y mantener a tu personaje con vida.

Desbloquea nuevas cartas y mejora tu baraja.


## Cómo Jugar

Movimiento: El personaje se mueve automáticamente hacia adelante.

Acciones: Usa los botones A, B, X e Y (o WASD) para realizar acciones como saltar, disparar o hacer un dash.

Rotación de Acciones: Cada vez que usas una acción, el botón se reasigna aleatoriamente con una nueva acción de tu baraja.

Sobrevive: Evita o derrota a los enemigos, supera obstáculos, y avanza tanto como puedas.


## Versión web

`export_presets.cfg` tiene un preset «Web» y la action `.github/workflows/web.yml` exporta el juego con Godot 4.3 y lo publica en GitHub Pages cada vez que se sube algo a `main`. Se exporta sin hilos para que funcione en GitHub Pages, que no permite configurar las cabeceras COOP/COEP.

Para exportarlo a mano: Godot 4.3 o superior → Proyecto → Exportar → Web.

