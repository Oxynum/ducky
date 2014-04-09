require 'csv'

class ConfigurationFile < ActiveRecord::Base


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |configuration_file|
        csv << configuration_file.attributes.values_at(*column_names)
      end
    end
  end
end
