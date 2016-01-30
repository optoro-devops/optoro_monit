# Guardfile
# More info at https://github.com/guard/guard#readme

guard :rubocop do
  watch(/.+\.rb/)
  watch(%r{(?:.+/)?.rubocop.yml$}) { |m| File.dirname(m[0]) }
end

guard 'foodcritic', cookbook_paths: '.' do
  watch(%r{attributes/.+.rb})
  watch(%r{providers\/.+\.rb})
  watch(%r{recipes/.+.rb})
  watch(%r{resources/.+.rb})
end

guard :bundler do
  watch('Gemfile')
end

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+(_spec|Spec)\.(js|coffee)})
  watch(%r{^spec/.+_spec.rb$})
  watch(%r{^(recipes)/(.+).rb$}) { 'spec' }
  watch(%r{^(attributes)/(.+).rb$}) { 'spec' }
  watch(%r{^(providers)/(.+).rb$}) { 'spec' }
  watch(%r{^(resources)/(.+).rb$}) { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }
end
