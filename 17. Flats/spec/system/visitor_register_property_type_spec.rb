require 'rails_helper'

describe 'visitor register a new property type' do 
    it 'successfully' do 
        visit root_path
        click_on 'Registrar Novo Tipo de Imóvel'
        fill_in 'Tipo de Imóvel', with: 'Kitnet'
        click_on 'Salvar'

        expect(page).to have_content('Kitnet')
    end

    it 'and try to register an empty value' do 
        
        visit root_path
        click_on 'Registrar Novo Tipo de Imóvel'
        fill_in 'Tipo de Imóvel', with: ''
        click_on 'Salvar'

        expect(page).to have_content('Campo não pode estar em branco!')
    end

    it 'and property type already exists' do
        PropertyType.create!(name:'Kitnet')
        visit root_path
        click_on 'Registrar Novo Tipo de Imóvel'
        fill_in 'Tipo de Imóvel', with: 'Kitnet'
        click_on 'Salvar'

        expect(page).to have_content('Esse Tipo de imóvel já existe!')
    end
end
