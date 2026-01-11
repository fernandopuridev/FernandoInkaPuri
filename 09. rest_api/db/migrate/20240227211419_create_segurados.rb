class CreateSegurados < ActiveRecord::Migration[7.1]
  def change
    create_table :segurados do |t|
      t.string :nome
      t.string :cpf

      t.timestamps
    end
  end
end
