require "activate_my_directory/version"
require 'active_directory'
require 'yaml'

module ActivateMyDirectory
  class << self
    def yaml
      @yaml ||= YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config.yml'))
    end

    def settings
      @settings ||= {
        host: yaml['host'],
        port: yaml['port'],
        base: yaml['base'],
        auth: { method: :simple,
                username: "#{yaml['username']}@#{yaml['domain']}",
                password: yaml['password']
        },
        encryption: { method: :simple_tls }
      }
    end

    def setup
      ActiveDirectory::Base.setup(settings) unless @setup
      @setup = true
    end

    def authenticate(username, password)
      setup
      user = ActiveDirectory::User.find(:first, userprincipalname: "#{username}@#{yaml['domain']}")
      return false unless user
      user.authenticate(password)
    end

    def user_is_in_group?(username, groupname)
      setup
      user = ActiveDirectory::User.find(:first, userprincipalname: "#{username}@#{yaml['domain']}")
      group = ActiveDirectory::Group.find(:first, cn: groupname)
      return false unless user && group
      user.groups.include?(group)
    end

    def authenticate_and_is_in_group?(username, password, groupname)
      authenticate(username, password) && user_is_in_group?(username, groupname)
    end
  end
end
