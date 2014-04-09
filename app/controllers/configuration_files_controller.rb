class ConfigurationFilesController < ApplicationController

  def show
    @file = ConfigurationFile.find params[:id]
    @xml_string = File.read("wix_files/#{@file.id}.wix")
    @property_hash = Hash.from_xml(@xml_string)
    respond_to do |format|
      format.json {render json: @property_hash.to_json}
      format.xml {render xml: @xml_string}
      format.csv {
        @csv = CSV.generate do |csv|
          csv << ["keyword", "target"]
          @property_hash["WIX"]["body"]["entry"].each do |entry|
            csv << [entry["keyword"], entry["target"]]
          end
        end
        send_data @csv
      }
    end
  end

  def index
    @files = ConfigurationFile.all
    respond_to do |format|
      format.json {render json: @files}
      format.xml {render xml: @files}
      format.csv {send_data @files.to_csv}
      format.xls { send_data @files.to_csv(col_sep: "\t") }
    end
  end

  def update
    @file = ConfigurationFile.find params[:id]
    @file.update file_params
  end

  private
  def file_params
    params.require(:file).permit(:name)
  end
end
