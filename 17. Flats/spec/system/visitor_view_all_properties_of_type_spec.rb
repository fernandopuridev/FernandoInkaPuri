require 'rails_helper'

describe 'Visitor view all properties of type' do 
    it 'Sucessfuly' do 
        casa = PropertyType.create!(name:'Casa')
        apartamento = PropertyType.create!(name:'Apartamento')
        luiz = PropertyOwner.create!(email: 'luiz@fernando.com.br', password: '12345678')
        rj = PropertyLocation.create!(name:'Rio de janeiro')
        Property.create!({title:'Casa com quintal em Copabana', 
                    description:'Excelente casa, recém reformada com 2 vagas de garagem', 
                    rooms:3, parking_slot: true, bathrooms: 2, pets: true,
                    daily_rate: 500, property_type_id: casa.id, property_location_id: rj.id, property_owner: luiz })
        
        visit root_path
        click_on 'Casa'

        expect(page).to have_content("Casa com quintal em Copabana")
        expect(page).to have_content("Tipo: Casa")
        expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
        expect(page).to have_content("Quartos: 3")
        expect(page).to have_content("Estacionamento: Sim")
        expect(page).to have_content("Banheiros: 2")
        expect(page).to have_content("Aceita Pets: Sim")
        expect(page).to have_content("Diária: R$ 500,00")
    end
end