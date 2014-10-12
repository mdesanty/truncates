require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_record'
require 'active_model'
require 'truncates'

#$:.unshift "#{File.dirname(__FILE__)}/../"
#$:.unshift "#{File.dirname(__FILE__)}/../lib/"
#$:.unshift "#{File.dirname(__FILE__)}/../lib/validations"


ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :truncates_customers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :city    
      t.string :state
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class TruncatesCustomer < ActiveRecord::Base
  validates :first_name, length: {maximum: 255}
  validates :middle_name, length: {maximum: 5}
  validates :last_name, length: {maximum: 10}
  validates :city, length: {maximum: 5}
  validates :state, length: {maximum: 5}
  
  truncates :first_name
  truncates :middle_name, max_length: 5
  truncates :last_name, max_length: 10, character_trail: "..."
  truncates :city, max_length: 5, on: :set
  truncates :state, max_length: 5, on: :validation
end

class TruncatesUser
  include ActiveModel::Validations
  extend Truncates
  
  attr_accessor :first_name,
                :middle_name,
                :last_name,
                :city,
                :state
                
  validates :first_name, length: {maximum: 255}
  validates :middle_name, length: {maximum: 5}
  validates :last_name, length: {maximum: 10}
  validates :city, length: {maximum: 5}
  validates :state, length: {maximum: 5}
  
  truncates :first_name, on: :set
  truncates :middle_name, max_length: 5, on: :set
  truncates :last_name, max_length: 10, character_trail: "...", on: :set
  truncates :city, max_length: 5, on: :set
  truncates :state, max_length: 5, on: :set
end