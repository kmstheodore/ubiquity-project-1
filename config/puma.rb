# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.

threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
threads threads_count, threads_count

port        ENV.fetch("PORT", 3000)
environment ENV.fetch("RACK_ENV", "development")

workers ENV.fetch("WEB_CONCURRENCY", 2).to_i
preload_app!

plugin :tmp_restart

# Remove or correct the line that references DefaultRackup
# rackup DefaultRackup
