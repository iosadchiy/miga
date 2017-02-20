require "csv"

namespace :import do
  desc "Import plots from a CSV file (passed as an argument)"
  # see example: test/fixtures/plots.csv
  task :plots, [:csv_file] => [:environment] do |task, args|
    CSV.foreach(args.csv_file, headers: :first_row) do |row|
      plot = Plot.create!(
        number: row[0],
        space: row[1],
        cadastre: row[2],
        ukrgosact: row[3]
      )
      puts "Created: #{plot.inspect}"
    end
  end
end
