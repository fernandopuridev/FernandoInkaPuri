require 'rails_helper'

describe 'Visitor visit Home Page' do 
  it 'and view properties' do 
    #Arrange (Preparar os dados)
    casa = PropertyType.create!(name:'Casa')
    apartamento = PropertyType.create!(name:'Apartamento')
    peter = PropertyOwner.create!(email: 'peter@parker.com.br', password: '123456789')
    rj = PropertyLocation.create!(name:'Rio de janeiro')
    Property.create!({title:'Casa com quintal em Copabana', 
                  description:'Excelente casa, recém reformada com 2 vagas de garagem', 
                  rooms:3, parking_slot: true, bathrooms: 4, pets: true,
                  daily_rate: 300, property_type_id: casa.id, property_location_id: rj.id, property_owner: peter  })
    Property.create!({title:'Cobertura em Manaus', 
                  description:'Cobertura de 300m2, churrasqueira e sauna privativa', 
                  rooms:5, parking_slot: true, bathrooms: 4, pets: true,
                  daily_rate: 300, property_type_id: apartamento.id, property_location_id: rj.id, property_owner: peter })
    #Act (Agir, executar a funcionalidade)
    visit root_path

    #Assert(Garantir, que algo aconteça ou não)
    expect(page).to have_content("Casa com quintal em Copabana")
    expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Cobertura em Manaus")
    expect(page).to have_content("Cobertura de 300m2, churrasqueira e sauna privativa")
    expect(page).to have_content("Quartos: 5")
  end

  it 'and theres no property available' do
    visit root_path
    expect(page).to have_content("Nenhum imóvel disponível")
  end

  it 'and view property details' do 
    casa = PropertyType.create!(name:'Casa')
    rj = PropertyLocation.create!(name:'Rio de janeiro')
    peter = PropertyOwner.create!(email: 'peter@parker.com.br', password: '123456789')

    Property.create!({title:'Casa com quintal em Copabana', 
                description:'Excelente casa, recém reformada com 2 vagas de garagem', 
                rooms:3, parking_slot: true, bathrooms: 2, pets: true,
                daily_rate: 500, property_type_id: casa.id, property_location_id: rj.id, property_owner: peter   })
    visit root_path
    click_on 'Casa com quintal em Copabana' 

    expect(page).to have_content("Casa com quintal em Copabana")
    expect(page).to have_content("Tipo: Casa")
    expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Estacionamento: Sim")
    expect(page).to have_content("Banheiros: 2")
    expect(page).to have_content("Aceita Pets: Sim")
    expect(page).to have_content("Diária: R$ 500,00")

  end

  it 'and view property details and return to home page' do
    casa = PropertyType.create!(name:'Casa')
    apartamento = PropertyType.create!(name:'Apartamento')
    rj = PropertyLocation.create!(name:'Rio de janeiro')
    peter = PropertyOwner.create!(email: 'peter@parker.com.br', password: '123456789')
    Property.create!({title:'Casa com quintal em Copacabana', 
                  description:'Excelente casa, recém reformada com 2 vagas de garagem', 
                  rooms:3, parking_slot: true, bathrooms: 4, pets: true,
                  daily_rate: 300, property_type_id: casa.id, property_location_id: rj.id, property_owner: peter  })
    Property.create!({title:'Cobertura em Manaus', 
                  description:'Cobertura de 300m2, churrasqueira e sauna privativa', 
                  rooms:5, parking_slot: true, bathrooms: 4, pets: true,
                  daily_rate: 300, property_type_id: apartamento.id, property_location_id: rj.id, property_owner: peter  })
    #Act => Agir (executar a funcionalidade)
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Voltar'

    #Assert => Garantir (que algo aconteceu ou NAO aconteceu)
    expect(current_path).to eq root_path
    expect(page).to have_link('Casa com quintal em Copacabana')
    expect(page).to have_content('Cobertura em Manaus')
  end
end


