require 'rubygems'
require 'commander/import'
require 'watir-webdriver'
require 'headless'

program :version, '0.0.1'
program :description, 'CRUD Urban Airship Apps'
 
command :new do |c|
  c.syntax = 'urbapp new [options]'
  c.summary = 'Create a new app'
  c.description = 'Creates a new Urban Airship app using passed in options'
  c.example 'Production App with Headless browser', 'new --username myUsern0me --password P0ny --name "Awesome Pocahontas" --certificate /path/to/certificate.cer --certificate-password mySecretC3rt --headless'
  c.example 'Development App', 'new --username myUsern0me --password P0ny --name "Awesome Pocahontas" --development'
  c.option '--username USERNAME', String, 'Urban Airship Username'
  c.option '--password PASSWORD', String, 'Urban Airship Password'
  c.option '--name NAME', String, 'Application name'
  c.option '--certificate PATH', String, 'Path to certificate eg. /path/to/certificate.p12'
  c.option '--certificate-password PASSWORD', String, 'Certificate password'
  c.option '--headless', 'Run a headless browser using Xvfb'
  c.option '--development', 'Creates a development certificate, skip --certificate, --certificate-password'
  c.action do |args, options|


  		if options.headless
  			headless = Headless.new
  			headless = headless.start
  		end

		b = Watir::Browser.new :firefox

		b.goto 'https://go.urbanairship.com/accounts/login/'

		b.text_field(:id => 'id_username').set(options.username)
		b.text_field(:id => 'id_password').set(options.password)
		b.input(:xpath, "//input[@value='Log In']").click

		b.goto 'https://go.urbanairship.com/apps/new'
		b.text_field(:id => 'id_name').set(options.name)

		if options.development
			b.select_list(:id => "id_mode").select_value 'development'
			b.select_list(:id => 'id_category').select 'Newsstand'
		else
			b.select_list(:id => 'id_mode').select_value 'production'
			b.select_list(:id => 'id_category').select 'Newsstand'

			b.file_field(:id => 'id_certificate').set(options.certificate)
			b.text_field(:id => 'id_certificate_password').set(options.certificate_password)
		end

		b.checkbox(:id => 'id_push_enabled').set

		b.button(:value => 'Create your application').click

		b.link(:id => 'app_secret_show').click
		b.link(:id => 'app_master_secret_show').click
		
		b.link(:xpath, "//a[@id='app_master_secret_hide' and @style='display: inline;']").wait_until_present

		app_key = b.dd(:id => 'app_key').text
		app_secret = b.span(:id => 'app_secret').text
		app_master_secret = b.span(:id => 'app_master_secret').text

		say "-------------------------------------------"
		say "App Key: #{app_key}"
		say "App Secret: #{app_secret}"
		say "App Master Secret: #{app_master_secret}"
		say "-------------------------------------------"

		begin
			b.close
			headless.destroy
		rescue
			# ;-)
		end
  end
end

