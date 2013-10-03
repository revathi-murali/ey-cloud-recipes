
node[:applications].each do |app_name,data|
  template "/data/#{app_name}/shared/config/gnip.yml" do
    source "gnip.yml.erb"
    owner "root"
    group "root"
    
    if node[:environment][:framework_env] == "production"
      variables(:yaml_file => 
      {
        node[:environment][:framework_env] => 
        {
          :user_name => default[:gnip][:user_name],
          :password => default[:gnip][:password],
          :rules_url =>  "https://api.gnip.com:443/accounts/Freshdesk/publishers/twitter/streams/track/prod/rules.json",
          :replay_rules_url => "https://api.gnip.com:443/accounts/Freshdesk/publishers/twitter/replay/track/prod/rules.json",
          :stream_url => "https://stream.gnip.com:443/accounts/Freshdesk/publishers/twitter/streams/track/prod.json",
          :replay_stream_url => "https://stream.gnip.com:443/accounts/Freshdesk/publishers/twitter/replay/track/prod.json"
        } 
      } )
    else
      variables(:yaml_file => 
      {
        node[:environment][:framework_env] => 
        {
          :user_name => default[:gnip][:user_name],
          :password => default[:gnip][:password],
          :rules_url => "https://api.gnip.com:443/accounts/Freshdesk/publishers/twitter/streams/track/dev/rules.json",
          :replay_rules_url => "https://api.gnip.com:443/accounts/Freshdesk/publishers/twitter/replay/track/prod/rules.json",
          :stream_url => "https://stream.gnip.com:443/accounts/Freshdesk/publishers/twitter/streams/track/dev.json",
          :replay_stream_url => "https://stream.gnip.com:443/accounts/Freshdesk/publishers/twitter/replay/track/prod.json"
        }
      } )
    end
  end
end