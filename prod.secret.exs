# Pleroma instance configuration

# NOTE: This file should not be committed to a repo or otherwise made public
# without removing sensitive information.

import Config

config :pleroma, Pleroma.Web.Endpoint,
   url: [host: "social.localhost", scheme: "https", port: 443],
   http: [ip: {127, 0, 0, 1}, port: 4000],
   secret_key_base: "qq84TmSDMFY8acVX9i6iW8UxRORyV1U80WJ271Hrq+5B73vKHY4qnjLZDPdCliQn",
   live_view: [signing_salt: "FrIb1QXm"],
   signing_salt: "/E3wQfCf"

config :pleroma, :instance,
  name: "Test Soapbox instance !",
  email: "foo@localhost.com",
  notify_email: "foo@localhost.com",
  limit: 5000,
  registrations_open: true

config :pleroma, :media_proxy,
  enabled: false,
  redirect_on_failure: true
  #base_url: "https://cache.pleroma.social"

config :pleroma, Pleroma.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "pleroma",
  password: "pleroma",
  database: "pleroma",
  hostname: "localhost"

# Configure web push notifications
config :web_push_encryption, :vapid_details,
  subject: "mailto:foo@localhost.com",
  public_key: "BDCvpYOX_jbdX5-g2z-WFwXk0OCThlh86C1WoPc8_SvYOseI8rkM9_7Fqlu7xC7zInhY8E2nd6RglMNuj7-o9eQ",
  private_key: "wZp0UrvH__5pKpIywpAEy4ck-b6As6ONGIaNX6bUNgc"

config :pleroma, :database, rum_enabled: false
config :pleroma, :instance, static_dir: "/opt/pleroma/instance/static"
config :pleroma, Pleroma.Uploaders.Local, uploads: "/opt/pleroma/uploads"

# Enable Strict-Transport-Security once SSL is working:
# config :pleroma, :http_security,
#   sts: true

# Configure S3 support if desired.
# The public S3 endpoint (base_url) is different depending on region and provider,
# consult your S3 provider's documentation for details on what to use.
#
# config :pleroma, Pleroma.Upload,
#  uploader: Pleroma.Uploaders.S3,
#  base_url: "https://s3.amazonaws.com"
#
# config :pleroma, Pleroma.Uploaders.S3,
#   bucket: "some-bucket",
#   bucket_namespace: "my-namespace",
#   truncated_namespace: nil,
#   streaming_enabled: true
#
# Configure S3 credentials:
# config :ex_aws, :s3,
#   access_key_id: "xxxxxxxxxxxxx",
#   secret_access_key: "yyyyyyyyyyyy",
#   region: "us-east-1",
#   scheme: "https://"
#
# For using third-party S3 clones like wasabi, also do:
# config :ex_aws, :s3,
#   host: "s3.wasabisys.com"

config :joken, default_signer: "M5x2dECmJiuOHWRzf74gVPd4HPCCW4Sq0x6zfqOtotzDmqsYP5p/SFxT7ldFdgZm"

config :pleroma, configurable_from_database: true

config :pleroma, Pleroma.Upload, filters: [Pleroma.Upload.Filter.Exiftool.ReadDescription]
