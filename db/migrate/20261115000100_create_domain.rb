class CreateDomain < ActiveRecord::Migration[8.1]
 def change
create_table(:envelopes){|t|t.string :name,null:false,limit:80;t.bigint :allocation_minor,null:false;t.bigint :remaining_minor,null:false}
add_index :envelopes,:name,unique:true
add_check_constraint :envelopes,'allocation_minor>0 AND remaining_minor>=0 AND remaining_minor<=allocation_minor',name:'envelope_amounts_valid'
create_table(:spends){|t|t.references :envelope,null:false,foreign_key:true;t.string :reference,null:false,limit:64;t.bigint :amount_minor,null:false}
add_index :spends,[:envelope_id,:reference],unique:true
add_check_constraint :spends,'amount_minor>0',name:'spend_positive'
 end
end
