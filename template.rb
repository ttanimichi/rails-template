run 'cp /dev/null README.md'
run "echo '/vendor/bundle' >> .gitignore"

application  do
  %q{
    config.time_zone = 'Tokyo'

    config.generators do |generators|
      generators.assets false
      generators.helper false
      generators.stylesheets false
      generators.javascripts false
    end

    config.autoload_paths << "#{config.root}/app/services"  
  }
end

gsub_file 'Gemfile', /\A.*web-console.*\z/ , ''
gsub_file 'Gemfile', /\A.*byebug.*\z/ , ''
gsub_file 'Gemfile', /\A.*jbuilder.*\z/ , ''

gem 'slim-rails'

gem_group :development, :test do
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'awesome_print'
end

run 'bundle install --without production --path vendor/bundle'

rake 'db:create'
rake 'db:migrate'

git :init
git add: '.'
git commit: "-m 'Initial commit'"
