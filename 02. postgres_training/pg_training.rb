require 'pg'

def connect_to_database
  # Alias para 	PG::Connection.new e PG::Connection.open
  PG.connect(
    dbname: 'training_db',
    user: 'trainer',
    password: 'secret',
    host: 'localhost',
    port: 5433
  )
end

def create_pets_table(conn)
  conn.exec("CREATE TABLE IF NOT EXISTS pets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    species VARCHAR(100),
    age INT
  );")
  puts 'Tabela de pets criada!'
end

def populate_pets_table(conn)
  pets = [['ScoobyDoo', 'Dog', 5], ['Pikachu', 'Pokemon', 3], ['Noturno', 'Cat', 6], ['Tanguá', 'Monkey', 7]]
  
  pets.each do |pet|
    conn.exec_params("INSERT INTO pets (name, species, age) VALUES ($1, $2, $3);", pet)
  end
  puts 'Dados inseridos na tabela de pets!'
end

def show_pets(conn)
  result = conn.exec("SELECT * FROM pets")
  result.each do |row|
    puts "ID: #{row['id']}, Name: #{row['name']}, Species: #{row['species']}, Age: #{row['age']}"
  end
end

def container_exists?
  container_id = `docker ps -a -q -f name=postgres_training`
  !container_id.empty?
end

def start_database
  puts 'Iniciando container de banco de dados'
  if container_exists?
    system('docker start postgres_training')
  else
    system("docker run --name postgres_training -e POSTGRES_USER=trainer -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=training_db -p 5433:5432 -d postgres")
  end 
  sleep (7)
end

begin
  start_database
  
  conn = connect_to_database
  
  create_pets_table(conn)
  populate_pets_table(conn)
  show_pets(conn)
  
rescue PG::Error => e
  puts "Erro: #{e.message}"
ensure
  conn.close if conn
end
