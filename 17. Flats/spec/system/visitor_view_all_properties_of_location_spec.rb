require 'rails_helper'

describe 'Visitor view all properties of location' do 
    it 'sucessfully' do 
        casa = PropertyType.create!(name: 'Casa')
        maceio = PropertyLocation.create!(name:'Maceió')
        petrolina = PropertyLocation.create!(name:'Petrolina')
        luiz = PropertyOwner.create!(email: 'luiz@fernando.com.br', password: '12345678')
        Property.create!({title:'Mansão na Praia de Maceió', 
                  description:'Linda mansão em lugar surpeendente', 
                  rooms:3, parking_slot: true, bathrooms: 2, pets: true,
                  daily_rate: 300, property_type_id: casa.id, property_location_id: maceio.id, property_owner: luiz })

        visit root_path
        click_on 'Maceió'

        expect(page).to have_content('Mansão na Praia de Maceió')
        expect(page).to have_content('Linda mansão em lugar surpeendente')
        expect(page).to have_content("Quartos: 3")
        expect(page).to have_content("Banheiros: 2")
        expect(page).to have_content("Aceita Pets: Sim")
        expect(page).to have_content("Estacionamento: Sim")
        expect(page).to have_content("Diária: R$ 300,00")
    end
end