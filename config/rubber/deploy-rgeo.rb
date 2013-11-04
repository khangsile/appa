namespace :rubber do 
  namespace :rgeo do 

    after "rubber:install_gems", "rubber:rgeo:install_rgeo" 
    task :install_rgeo do 
      #Install the rgeo gem with the path to the required libraries 
      rubber.sudo_script "install_rgeo", <<-SCRIPT
        gem install rgeo -- --with-geos-dir=/usr/lib/ 
      SCRIPT
    end 

  end 
end 