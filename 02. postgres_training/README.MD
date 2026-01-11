# SQL PG Training:

Projeto Ruby com o intuito mostrar didaticamete uma forma de uso de SQL em Ruby sem o Active Record (componente padrão do Ruby on Rails que faz a comunicação com o banco de dados).

Em um arquivo fiz um script que mostra o funcionamento da Gem PG para comunicação com o banco de dados. No outro arquivo estou fazendo um script que tem o intuito de ensinar SQL de forma interativa.

## Pré-requisitos

Antes de executar o projeto, certifique-se de que você possui as seguintes dependências:

- **libpq-dev**: Este pacote é necessário para instalar a gem `pg` e permitir sua comunicação com o PostgreSQL.  Para instalar, execute o seguinte comando:

  ```bash
  sudo apt-get install libpq-dev
  ```

- **gem pg**: A gem que utilizaremos para interagir com o banco de dados PostgreSQL. Para instalar, basta exucutar o comando:

  ```bash
  gem install pg
  ```

- **Docker**: É necessário pois vamos executar o banco de dados PostgreSQL em um conteiner. Para instalar o Docker, siga as instruções no site oficial. 

## Como executar

- Clone o repositório
- Garanta que as dependências mencionadas estejam instaladas
- **Não é necessário subir o container do postgres pois isso já é feito no código do script**
- Execute com o comando dentro do repositório:
  ```bash
  ruby pg_training.rb
  ```

