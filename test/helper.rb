require 'minitest/autorun'
require 'active_record'

require 'rails/observers/activerecord/active_record'

FIXTURES_ROOT = File.expand_path(File.dirname(__FILE__)) + "/fixtures"

class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures

  self.fixture_path = FIXTURES_ROOT
  self.use_instantiated_fixtures  = false
  self.use_transactional_fixtures = true

  def create_fixtures(*fixture_set_names, &block)
    ActiveRecord::FixtureSet.create_fixtures(ActiveSupport::TestCase.fixture_path, fixture_set_names, fixture_class_names, &block)
  end
end

ActiveRecord::Base.logger = ActiveSupport::Logger.new("debug.log", 0, 100 * 1024 * 1024)
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table :topics do |t|
    t.string   :title
    t.string   :author_name
    t.string   :author_email_address
    t.datetime :written_on
    t.time     :bonus_time
    t.date     :last_read
    t.text     :content
    t.text     :important
    t.boolean  :approved, :default => true
    t.integer  :replies_count, :default => 0
    t.integer  :parent_id
    t.string   :parent_title
    t.string   :type
    t.string   :group
    t.timestamps
  end

  create_table :comments do |t|
    t.string :title
  end

  create_table :minimalistics do |t|
    t.string :title
  end

  create_table :developers do |t|
    t.string :name
    t.integer :salary
  end
end

class Comment < ActiveRecord::Base
  def self.lol
    "lol"
  end
end

class Developer < ActiveRecord::Base
end

class Minimalistic < ActiveRecord::Base
end

ActiveSupport::Deprecation.silence do
  require 'active_record/test_case'
end
