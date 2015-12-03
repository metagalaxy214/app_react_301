class Content < ActiveRecord::Base
  before_save :translate_line_breaks


  def translate_line_breaks
    self.body = self.body.to_s.gsub("\r", "")
  end
end
