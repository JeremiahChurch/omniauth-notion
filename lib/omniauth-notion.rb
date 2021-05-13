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
        connection_opts: { headers: { user_agent: 'Omniauth-notion', accept: 'application/json', content_type: 'application/json' } }

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
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.post('v1/oauth/token', body: nil.to_json).parsed
      end

      def callback_url
        if @authorization_code_from_signed_request
          ''
        else
          options[:callback_url] || super
        end
      end

      # def callback_url
      #   # If redirect_uri is configured in token_params, use that
      #   # value.
      #   token_params.to_hash(symbolize_keys: true)[:redirect_uri] || super
      # end

      def query_string
        # This method is called by callback_url, only if redirect_uri
        # is omitted in token_params.
        if request.params['code']
          # If this is a callback, ignore query parameters added by
          # the provider.
          ''
        else
          super
        end
      end
    end
  end
end
