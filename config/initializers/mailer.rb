module Agendatech
  mattr_accessor :mailer_from, :mailer_to

  keys = YAML.load(IO.read("config/mailer.yml"))[Rails.env]
  keys = keys["approve"].with_indifferent_access
  self.mailer_from = keys[:from]
  self.mailer_to   = keys[:to]
end
