# urbapp

Just a simple CLI to help you quickly create apps on Urban Airship. Our iOS dev does this a lot so this will help him out. And it's always fun to automate stuff ;-)

Requirements:

	Firefox needs no driver to work with watir and that's why it's easiest to just have Firefox installed on your computer ;-)

Example:
	
	./urbapp new --username myUsern0me --password P0ny --name "Awesome Pocahontas" --certificate /path/to/certificate.cer --certificate-password mySecretC3rt --headless

Outputs:

	-------------------------------------------
	App Key: kAWIDb29udniawd2
	App Secret: kadin12dinaiwd9WAINOw
	App Master Secret: ajkwdnw91d012QWdwadAWDw
	-------------------------------------------

./urbapp --help
	
	SYNOPSIS:

		urbapp new [options]

		DESCRIPTION:

		Creates a new Urban Airship app using passed in options

		EXAMPLES:
			
		# Production App with Headless browser
		new --username myUsern0me --password P0ny --name "Awesome Pocahontas" --certificate /path/to/certificate.cer --certificate-password mySecretC3rt --headless
			
		# Development App
		new --username myUsern0me --password P0ny --name "Awesome Pocahontas" --development
			
		OPTIONS:
			
		--username USERNAME 
			Urban Airship Username
			
		--password PASSWORD 
			Urban Airship Password
			
		--name NAME 
			Application name
			
		--certificate PATH 
			Path to certificate eg. /path/to/certificate.p12
			
		--certificate-password PASSWORD 
			Certificate password
			
		--headless 
			Run a headless browser using Xvfb
			
		--development 
			Creates a development certificate, skip --certificate, --certificate-password

## Headless mode
I've also included [headless](https://github.com/leonid-shevtsov/headless) so that if you are running an application using X (most apps on *nix, a few on OSX) it will run in the background.

## License
Do-exactly-what-you-want-with-it-I-do-not-care-license