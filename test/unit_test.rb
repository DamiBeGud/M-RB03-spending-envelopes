# No schema helper/fixtures. PG connections are forbidden in this unit suite.
ENV['RAILS_ENV']='test'
ENV['DATABASE_URL']='postgresql://127.0.0.1:9/unused_unit_test_database'
ENV['API_TOKEN']='synthetic-unit-token'
require_relative '../config/boot'
require 'pg'
module NoDatabaseInUnitTests
 def new(*) = raise('database_connection_forbidden_in_unit_tests')
 def connect(*) = raise('database_connection_forbidden_in_unit_tests')
end
PG::Connection.singleton_class.prepend(NoDatabaseInUnitTests)
require_relative '../config/environment'
require 'minitest/autorun'
require 'rack/test'
class UnitTest < Minitest::Test
 include Rack::Test::Methods
 def app = Rails.application
 def test_liveness
  get '/health/live';assert_equal 200,last_response.status
 end
 def test_business_boundaries
  assert_equal 750,Input.remaining!(1000,250);assert_raises(Problem){Input.remaining!(750,751)};assert_raises(Problem){Input.remaining!(10,-1)}
 end
 def test_input_or_auth_before_database
  assert_raises(Problem){Input.amount(-1)};assert_raises(Problem){Input.text(' ')}
 end
end
