# Calculadora Web com Autenticação

> Um projeto com uma App React e uma API Node para realizar operações matemáticas básicas (soma, subtração, multiplicação e divisão), com autenticação de usuários utilizando JWT (JSON Web Token). Utilizei bcrypt também para gerar uma senha criptografada.

## Índice

1. [Visão Geral](#visão-geral)
2. [Tecnologias](#tecnologias)
3. [Como Rodar o Projeto](#como-rodar-o-projeto)

## Visão Geral

Esta é uma aplicação de calculadora web que permite aos usuários realizar operações matemáticas básicas após fazer login. A autenticação de usuários é feita utilizando JWT, e a aplicação é dividida entre backend (Node.js) e frontend (React).

## Tecnologias

- **Backend**: Node.js, Express, JWT, bcrypt
- **Frontend**: React.js, React Router
- **Outros**: Docker, Docker Compose

## Como Rodar o Projeto

#### 1. Clone este repositório para sua máquina:

```bash
git clone https://github.com/FernandoInkaPuri/AuthCalcApp.git
```
#### 2. Entre na pasta com o comando `cd AuthCalcApp`

#### 3. Suba a aplicação com o docker compose
```
docker compose up
```
