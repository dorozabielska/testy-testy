require 'selenium-webdriver'
require 'rspec'
require 'test-unit'
require 'test/unit/assertions'
require 'faker'

include Test::Unit::Assertions

class FullPageTest

  describe 'QA site test' do

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

    it 'tests registration form', :registration, :positive do
      @driver.get(@base_url + '/registration')
      @driver.find_element(:id, 'name_3_firstname')
        .send_keys(Faker::Name.unique.first_name + ' ' + Faker::Number.number(10))
      @driver.find_element(:id, 'name_3_lastname')
        .send_keys(Faker::Name.unique.last_name + ' ' + Faker::Number.number(10))
      #TODO: find something better than xpath
      @driver.find_element(:xpath, "//*[@id='pie_register']/li[3]/div/div/input[2]").click
      @driver.find_element(:id, 'phone_9')
        .send_keys('48' + Faker::Number.number(9))
      @driver.find_element(:id, 'username')
        .send_keys(Faker::Name.unique.name + ' ' + Faker::Number.number(10))
      @driver.find_element(:id, 'email_1')
        .send_keys('doro.zabielska' + '+' +Faker::Number.number(10) + '@gmail.com')
      password=Faker::Internet.password(8)
      @driver.find_element(:id, 'password_2')
        .send_keys(password)
      @driver.find_element(:id, 'confirm_password_password_2')
        .send_keys(password)
      @driver.find_element(:name, 'pie_submit').click
      assert_equal @driver.find_element(:class => 'piereg_message').text, 'Thank you for your registration'
      #sleep(10)
    end

    it 'checks if the hover is working', :start do
      @driver.get(@base_url)
      assert_true(@driver.find_elements(:class, 'ui-tooltip-content').empty?)
      @driver.action.move_to(@driver.find_element(id: 'menu-item-158'), 10, 10).perform
      assert_true(@driver.find_elements(:class, 'ui-tooltip-content').any?)
    end

  end

end
