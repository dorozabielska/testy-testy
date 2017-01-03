require 'selenium-webdriver'
require 'rspec'
require 'test-unit'
require 'test/unit/assertions'
require 'faker'

include Test::Unit::Assertions

class FullPageTest

  describe 'QA home site test' do

    before(:each) do
      @driver = Selenium::WebDriver.for :chrome
      @base_url = 'http://www.demoqa.com'
      @accept_next_alert = true
      @driver.manage.timeouts.implicit_wait = 10
    end

    after(:each) do
      @driver.quit
    end

    it 'changes the page to about us' do
      @driver.get(@base_url + '/')
      @driver.find_element(:id, 'menu-item-158').click
      assert_equal @driver.find_element(:class => 'entry-title').text, 'About us'
      assert_equal @driver.title, 'About us | Demoqa'
    end

    it 'checks if the hover is working', :start do
      @driver.get(@base_url)
      assert_true(@driver.find_elements(:class, 'ui-tooltip-content').empty?)
      @driver.action.move_to(@driver.find_element(id: 'menu-item-158'), 10, 10).perform
      assert_true(@driver.find_elements(:class, 'ui-tooltip-content').any?)
    end

  end

end
