namespace :agendatech do
  desc "deixando todo mundo sem ser destaque"
  task :ninguem_eh_destaque => :environment do
    Evento.update_all(:destaque => false)
  end

end