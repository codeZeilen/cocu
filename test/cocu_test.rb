require 'test_helper'
require 'cucumber/formatter/cocu'

class CocuTest < ActiveSupport::TestCase

  test "truth" do
    assert_kind_of Module, Cocu
  end

end

class Cucumber::Formatter::CoCu
  #public :reformat_name
end

class CocuFormatterTest < ActiveSupport::TestCase

  test "reformat name string" do
    name_string = "In order to xy\nAs a role\n I want to make a pie.\n"
    new_name_string = "In order to xy As a role\nI want to make a pie."
    assert_reformat_to name_string, new_name_string
  end

  test "reformat long name string " do
    #Contains 133 characters
    name_string = %q(In order to xy As a Role I want to make a 
bananananananananananananananananananananana
banananananananananananananananananananana pie)

    #Contains 128 Characters
    short_name_string = %q(In order to xy As a Role
I want to make a banananananananananananananananana
nanananana banananananananananananananananananan...)

    assert_reformat_to name_string, short_name_string 
  end

  private

  def assert_reformat_to(old_string, new_string)
    a = Cucumber::Formatter::CoCu.new(nil, "./testlog", nil)
    r = a.reformat_name(old_string)
    assert_equal new_string, r
  end

end
