require "lita"
require "circleci"

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/slack_circleci_deploy"

Lita::Handlers::SlackCircleciDeploy.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
