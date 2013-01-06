#!/usr/bin/env ruby

#require 'rubygems'
require 'gdata'
require 'optparse'

$0 = File.basename($0)
options = {}

ARGV.options do |opt|
	opt.banner = "Usage: backup_gcontacts --username USERNAME --password PASSWORD OUTPUT_PATH"
	opt.on('-u','--username USERNAME', 'Google username, use your full gmail address') do |user|
		options[:user] = user
	end
	opt.on('-p','--password PASSWORD', 'Your password, used to perform the request (if you have two-factor authentication,and you should,just generate a new app password') do |password|
		options[:password] = password
	end

	opt.on_tail('-h','--help', 'Display this screen') do
		puts opt.help
		exit
	end

	opt.parse!
end

options[:path] = ARGV.pop||"./"

# All parameters are mandatory actually
ARGV.options.abort('Username is missing') if options[:user].nil?
ARGV.options.abort('Password is missing') if options[:password].nil?

client = GData::Client::Contacts.new
client.clientlogin(options[:user], options[:password])

dump = client.get( "https://www.google.com/m8/feeds/contacts/#{options[:user]}/full/?max-results=10000")

if dump
	dump = dump.to_xml
	file = File.open( File.join(options[:path],"export_#{Time.now.strftime('%Y%m%d_%H%M%S')}.xml") , 'w')
	file.write(dump)

	puts "Sucessfully dumped #{dump.root.elements.size} contacts"
end
