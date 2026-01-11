require 'rails_helper'

describe 'Visitor edit property' do
    it 'sucefully' do
        PropertyType.create!(name: 'Casa')
        PropertyLocation.create!(name:'Maceió')
        jane = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        Property.create!({title:'Mansão em Maceió', 
                  description:'Linda mansão perto da praia', 
                  rooms:3, parking_slot: true, bathrooms: 4, pets: true,
                  daily_rate: 300, property_type_id: 1, property_location_id: 1, property_owner: jane })
        visit root_path
        click_on 'Mansão em Maceió'
        click_on 'Editar informações do Imóvel'

        fill_in 'Título', with: 'Mansão na Praia de Maceió'
        select 'Casa', from: 'Tipo'
        fill_in 'Descrição', with: 'Linda mansão em lugar surpeendente'
        fill_in 'Quartos', with: '3'
        fill_in 'Banheiros', with: '2'
        fill_in 'Diária', with: 450
        check 'Aceita Pets'
        check 'Vaga de Estacionamento'
        click_on 'Enviar'

        expect(page).to have_content('Mansão na Praia de Maceió')
        expect(page).to have_content('Linda mansão em lugar surpeendente')
        expect(page).to have_content("Quartos: 3")
        expect(page).to have_content("Banheiros: 2")
        expect(page).to have_content("Aceita Pets: Sim")
        expect(page).to have_content("Estacionamento: Sim")
        expect(page).to have_content("Diária: R$ 450,00")
    end
end
