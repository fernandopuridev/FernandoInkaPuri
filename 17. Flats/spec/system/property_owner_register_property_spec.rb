require 'rails_helper'

describe 'Property Owner register property' do
  it 'successfully' do
    #Arrange
    proprietario = PropertyOwner.create!(email: 'luiz@fernando.com.br', password: '12345678')
    PropertyType.create!(name: 'Casa')
    PropertyLocation.create!(name:'Florianópolis')
    login_as proprietario , scope: :property_owner
    #Act
    visit root_path
    click_on 'Cadastrar Imóvel'
    fill_in 'Título', with: 'Casa em Florianópolis'
    select 'Casa', from: 'Tipo:'
    select 'Florianópolis', from: 'Região:'
    fill_in 'Descrição', with: 'Ótima casa perto da UFSC'
    fill_in 'Quartos', with: '3'
    fill_in 'Banheiros', with: '2'
    fill_in 'Diária', with: 200
    check 'Aceita Pets'
    check 'Vaga de Estacionamento'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Casa em Florianópolis')
    expect(page).to have_content('Ótima casa perto da UFSC')
    expect(page).to have_content("Tipo: Casa")
    expect(page).to have_content("Região: Florianópolis")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Banheiros: 2")
    expect(page).to have_content("Aceita Pets: Sim")
    expect(page).to have_content("Estacionamento: Sim")
    expect(page).to have_content("Diária: R$ 200,00")
    expect(page).to have_content("Imóvel de: luiz@fernando.com.br")
  end

  it 'an fill empty value' do
    #Arrange
    proprietario = PropertyOwner.create!(email: 'luiz@fernando.com.br', password: '12345678')
    PropertyType.create!(name: 'Casa')
    PropertyLocation.create!(name:'Florianópolis')
    login_as proprietario , scope: :property_owner
    #Act
    visit root_path
    click_on 'Cadastrar Imóvel'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Quartos não pode ficar em branco')
    expect(page).to have_content('Banheiros não pode ficar em branco')
    expect(page).to have_content('Diária não pode ficar em branco')
  end

end