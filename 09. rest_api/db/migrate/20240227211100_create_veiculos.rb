class CreateVeiculos < ActiveRecord::Migration[7.1]
  def change
    create_table :veiculos do |t|
      t.string :marca
      t.string :modelo
      t.integer :ano
      t.string :placa

      t.timestamps
    end
  end
end
