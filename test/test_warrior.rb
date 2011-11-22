require 'helper'

class WarriorTest < Test::Unit::TestCase
  
  def setup
    @mock_ssh = mock
    @warrior = Sparta::Warrior.new(@mock_ssh)
    assert(@warrior.ssh)
    @weapon_sequence= sequence('random firing sequence')
    

  end
  

  
  def test_warrior
    mock_weapon = mock
    
    mock_weapon.expects(:install).with(@mock_ssh).in_sequence(@weapon_sequence)
    mock_weapon.expects(:'is_working?').returns(true).in_sequence(@weapon_sequence)
    mock_weapon.expects(:'use').in_sequence(@weapon_sequence)
    @warrior.arm(mock_weapon)
    assert(@warrior.is_armed?)
    
    # needs a target!
    assert_raise do
      @warrior.attack!
    end
    
    @warrior.target = 'http://localhost/'
    @warrior.attack!
  end
  

end
