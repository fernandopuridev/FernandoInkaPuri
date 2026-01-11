require 'pg'

class Database
  def start_database
    puts 'Iniciando container de banco de dados'
    if container_exists?
      system("docker start postgres_learning")
    else
      system("docker run --name postgres_learning -e POSTGRES_USER=trainer -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=training_db -p 5432:5432 -d postgres")
    end
    sleep(7)
  end

  def connect
    PG.connect(
      dbname: 'training_db',
      user: 'trainer',
      password: 'secret',
      host: 'localhost',
      port: 5432
    )
  end

  def close
    connect.close if connect
  end

  private

  def container_exists?
    container_id = `docker ps -a -q -f name=postgres_learning`
    !container_id.empty?
  end
end

class Pets
  class << self
    def create_table(conn)
      conn.exec("CREATE TABLE IF NOT EXISTS pets (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        species VARCHAR(100),
        age INT);"
      )

      if table_empty?(conn)
        seeds_pets(conn)
      end
    end

    def show_pets(conn)
      puts "Listando dados da tabela Pets"
      result = conn.exec("SELECT * FROM pets")
      result.each do |row|
        puts "ID: #{row['id']}, Name: #{row['name']}, Species: #{row['species']}, Age: #{row['age']}"
      end
    end

    private

    def table_empty?(conn)
      result = conn.exec("SELECT COUNT(*) FROM pets;")
      result[0]['count'].to_i == 0
    end

    def seeds_pets(conn)
      pets = [['Toby', 'Dog', 5], ['Bulbassaur', 'Pokemon', 3], ['Mavis', 'Cat', 6], ['Marú', 'Hawk', 7]]
      pets.each do |pet|
        conn.exec_params("INSERT INTO pets (name, species, age) VALUES ($1, $2, $3);", pet)
      end
      puts 'Tabela populada com sucesso!'
    end
  end
end

class LearnSql
  def self.menu(conn)
    while true do
      puts "\nMenu de Aprendizado de SQL:"
      puts "1. Criar tabelas"
      puts "2. Inserir dados"
      puts "3. Selecionar dados de uma tabela"
      puts "4. Selecionar dados filtrando com algum argumento"
      puts "5. Atualizar dados"
      puts "6. Deletar dados"
      puts "7. Voltar ao menu principal"
      print "Escolha uma opção: "

      choice = gets.chomp

      case choice
      when '1'
        puts "\nVamos tentar criar uma tabela?"
        puts "Podemos criar uma tabela usando o comando CREATE TABLE. Exemplo:"
        puts "CREATE TABLE football_teams (id SERIAL PRIMARY KEY, name VARCHAR(100), country VARCHAR(100), titles INT);\n"
        user_query(conn)
      when '2'
        puts "\nVamos tentar inserir dados em uma tabela?"
        puts "Podemos adicionar um registro em uma tabela, usando o comando INSERT INTO nome_da_tabela. Exemplo:"
        puts "INSERT INTO pets (name, species, age) VALUES ('Dudu', 'Dog', 5);\n"
  
        user_query(conn)
      when '3'
        puts "\nSelecionar os Dados de uma tabela:"
        puts "Podemos selecionar os dados de uma tabela, usando o comando SELECT. Exemplos:"
        puts "'SELECT * FROM pets;' para selecionar todos registros e suas colunas, ou 'SELECT name, species FROM pets' para trazer todos registros porém apenas colunas específicas\n"
  
        user_query(conn)
      when '4'
        puts "\nSelecionar dados filtrando por algum argumento:"
        puts "Podemos filtrar os dados usando WHERE. Exemplo:"
        puts "SELECT * FROM pets WHERE species = 'Dog';\n"
  
        user_query(conn)
      when '5'
        puts "\nAtualizar Dados:"
        puts "Podemos atualizar dados de uma tabela usando o comando UPDATE. Exemplo:"
        puts "UPDATE pets SET age = 6 WHERE name = 'ScoobyDoo';\n"
  
        user_query(conn)
      when '6'
        puts "\nDeletar Dados:"
        puts "Para deletar dados, usamos o comando DELETE. Exemplo:"
        puts "DELETE FROM pets WHERE name = 'ScoobyDoo';\n"
  
        user_query(conn)
      when '7'
        break
      else
        puts "Opção inválida. Tente novamente."
      end
    end
  end

  def self.user_query(conn)
    puts "Digite sua query SQL:"
    query = gets.chomp
    begin
      result = conn.exec(query)
      result.each { |row| puts row }
    rescue PG::Error => e
      puts "Erro na query: #{e.message}"
    end
  end
end

begin
  db_manager = Database.new
  db_manager.start_database
  
  conn = db_manager.connect
  Pets.create_table(conn)
  print "Bem vindos ao treino de SQL. Escolha uma opção: "

  while true do
    puts "\nMenu:"
    puts "1. Listar pets"
    puts "2. Executar uma query SQL"
    puts "3. Aprender a fazer queries SQL"
    puts "4. Sair"

    choice = gets.chomp

    case choice
    when '1'
      Pets.show_pets(conn)
    when '2'
      LearnSql.user_query(conn)
    when '3'
      LearnSql.menu(conn)
    when '4'
      break
    else
      puts "Opção inválida. Tente novamente."
    end
  end
rescue PG::ConnectionBad => e
  puts "Erro de conexão: #{e.message}"
ensure
  db_manager.close
  system("docker stop postgres_learning")
end
