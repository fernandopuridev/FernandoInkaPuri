require 'rails_helper'

describe 'Property owner view reservations' do
  it 'should view reservations from owned properties' do
    property_type = PropertyType.create!(name: 'Um tipo qualquer')
    john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456')
    petrolina = PropertyLocation.create!(name:'Petrolina')
    johns_property = Property.create!(title: 'Apartamento Novo',
                                description: 'Um apartamento legal',
                                rooms: 3, bathrooms: 2, pets: true, daily_rate: 100,
                                property_type: property_type, property_location:petrolina,
                                property_owner: john)

    andrew = User.create!(email: 'andrew@doe.com.br', password: '123456')

    PropertyReservation.create!(start_date: '2025-10-09', end_date: '2025-10-12',
                               guests: 6, property: johns_property, user: andrew)


    login_as john, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'
    click_on 'Apartamento Novo'

    expect(page).not_to have_content 'Reserve Agora'
    expect(page).to have_content 'Reservas'
    expect(page).to have_content 'Reserva de andrew@doe.com.br'
    expect(page).to have_content 'Data de Início: 09/10/2025'
    expect(page).to have_content 'Data de Saída: 12/10/2025'
    expect(page).to have_content 'Total de Pessoas: 6'
    expect(page).to have_content 'Status: Pendente'
  end
end