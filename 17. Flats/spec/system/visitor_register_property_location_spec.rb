require 'rails_helper'

describe 'Visitor register location' do 
    it 'sucessfully' do 
        
        visit root_path
        click_on 'Cadastrar Região'
        fill_in 'Nome da região', with: 'Bahia'
        click_on 'Salvar'

        expect(page).to have_content('Bahia')
    end

    it 'and try to register an empty value ' do

        visit root_path
        click_on 'Cadastrar Região'
        fill_in 'Nome da região', with: ''
        click_on 'Salvar'

        expect(page).to have_content('Campo não pode estar em branco!')
    end

    it 'and property location already exists' do 
        PropertyLocation.create!(name:'Pará')

        visit root_path
        click_on 'Cadastrar Região'
        fill_in 'Nome da região', with: 'Pará'
        click_on 'Salvar'

        expect(page).to have_content('Essa Região já existe, tente outra!')
    end
    
end