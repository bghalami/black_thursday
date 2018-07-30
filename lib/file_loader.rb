class FileLoader

  def self.load_csv(location, class_name)
    csv_array = []
    CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
      csv_array << class_name.new(row)
    end
    csv_array
  end

end
