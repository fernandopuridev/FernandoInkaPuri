class CreatePolicies < ActiveRecord::Migration[7.1]
  def change
    create_table :policies do |t|
      t.datetime :data_emissao
      t.datetime :data_fim_cobertura
      t.references :segurado, null: false, foreign_key: true
      t.references :veiculo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
