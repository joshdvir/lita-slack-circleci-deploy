module Lita
  module Handlers
    class SlackCircleciDeploy < Handler

      config :circleci_token, required: true
      config :circleci_username, required: true

      route(/^deploy\s+(.+)\s+in\s+(.+)\s+to\s+(.+)/, :deploy_circle, command: true, help: {
        "deploy [branch_name] in [project name] to [QA environment]" => "example: 'lita deploy develop in hello-world to qa1'"
      })

      def deploy_circle(response)
        token = config.circleci_token
        CircleCi.configure do |config|
          config.token = token
        end

        build_environment_variables = { "QA_ENV" => response.matches[0][2] }
        build = CircleCi::Project.build_branch config.circleci_username, response.matches[0][1], response.matches[0][0], build_environment_variables

        response.reply("Starting build @ #{build.body['build_url']}")
      end

    end

    Lita.register_handler(SlackCircleciDeploy)
  end
end
