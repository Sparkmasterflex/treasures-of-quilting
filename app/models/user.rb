class User < ActiveRecord::Base
  acts_as_authentic

  def last_updated
    options = {:conditions => {:updated_by => self.id}, :order => :updated_at}
    array = [Webpage.find(:first, options), Subpage.find(:first, options)].reject { |m| m.nil? }
    array.sort!{|a, b| a.updated_at <=> b.updated_at } << "No pages updated by #{self.login}"
    array.first.is_a?(String) ? array.first : array.first.page_alias
  end
end
