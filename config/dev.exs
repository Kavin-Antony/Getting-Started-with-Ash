import Config

# Configure your database
config :helpdesk, Helpdesk.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "helpdesk_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :helpdesk, HelpdeskWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "4q2+yJ0q6QY3k5ZkC5aX6Y7q8w9e0r1t2y3u4i5o6p7a8s9d0f1g2h3j4k5l6m7n8o9p0q1r2s3t4u5v6w7x8y9z0",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:helpdesk, ~w(--sourcemap=inline --watch)]}
  ],
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/helpdesk_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :ash, policies: [show_policy_breakdowns?: true]
