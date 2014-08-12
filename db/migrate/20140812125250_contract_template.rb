class ContractTemplate < ActiveRecord::Migration
  def change
    create_table :contract_templates do |t|
      t.integer :investment_contract_id
      t.string :type
      t.text :content
      
      t.timestamps
    end
  end
end
