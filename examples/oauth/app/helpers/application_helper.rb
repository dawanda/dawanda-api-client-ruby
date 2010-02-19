# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def has_credentials?
    OAUTH_CREDENTIALS.present? && OAUTH_CREDENTIALS[:dawanda] && OAUTH_CREDENTIALS[:dawanda][:secret].present? && OAUTH_CREDENTIALS[:dawanda][:key].present?
  end
end
