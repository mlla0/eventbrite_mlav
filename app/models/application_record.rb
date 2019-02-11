class ApplicationRecord < ActiveRecord::Base

	require 'time'
	require 'date'
  
  self.abstract_class = true
end
