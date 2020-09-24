class Website < ApplicationRecord
  belongs_to :user

  validates :original_url, url: true

  def get_additional_info
    generate_header_info
    generate_short_url
  end

  def generate_header_info
    doc = HTTParty.get(original_url)
    parsed_doc = Nokogiri::HTML::DocumentFragment.parse(doc)
    self.header_values = parsed_doc.css('h1, h2, h3').map(&:text)
  end

  def generate_short_url
   token = Rails.application.credentials.bitly[:token]
   self.short_url = Bitly::API::Client
                    .new(token: token)
                    .shorten(long_url: original_url)
                    .link
  end
end
