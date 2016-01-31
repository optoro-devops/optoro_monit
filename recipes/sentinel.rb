include_recipe 'optoro_monit'

monitrc 'sentinel' do
  template_cookbook 'optoro_monit'
  template_source 'sentinel.monitrc.erb'
end
