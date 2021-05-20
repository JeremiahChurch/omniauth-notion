# frozen_string_literal: true

require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Notion < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'notion'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options,
        site: 'https://api.notion.com/v1',
        authorize_url: 'https://api.notion.com/v1/oauth/authorize',
        token_url: 'https://api.notion.com/v1/oauth/token',
        connection_opts: {
          headers: {
            user_agent: 'Omniauth-notion',
            accept: 'application/json',
            content_type: 'application/json',
          },
        }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['bot_id'] }

      # https://developers.notion.com/docs/authorization#exchanging-the-grant-for-an-access-token
      info do
        {
          workspace_name: raw_info['workspace_name'],
          workspace_icon: raw_info['workspace_icon'],
          bot_id: raw_info['bot_id']
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      # The Notion API requires HTTP Basic Authentication when exchanging the
      # code for a token (i.e. when POSTing to /v1/oauth/token)
      #   Notion Docs: https://developers.notion.com/docs/authorization#exchanging-the-grant-for-an-access-token
      #   Similar solution: https://gist.github.com/handylearn/6d6125263d32544c2057#file-filab_strategy-rb-L35
      def build_access_token
        options.token_params.merge!(
          headers: { 'Authorization' => basic_auth_header },
        )
        super
      end

      def basic_auth_header
        "Basic " + Base64.strict_encode64("#{options[:client_id]}:#{options[:client_secret]}")
      end

      # The Notion API gives us some core data as part of the token response. I
      # don't think there is a separate /user/me endpoint (at least as of May
      # 2021). Also, we get a `bot_id`, not a real user ID. We do get some
      # informaton about the connector Organization, however.
      def raw_info
        @raw_info ||= access_token.params.except('access_token', 'bearer')
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
