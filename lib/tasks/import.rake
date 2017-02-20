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

  desc "Import members from a CSV file"
  # see example: test/fixtures/members.csv
  task :members, [:csv_file] => [:environment] do |task, args|
    CSV.foreach(args.csv_file, headers: :first_row) do |row|
      plot_numbers = row[0].split(/\s*,\s*/)
      plots = Plot.where(number: plot_numbers)
      raise "cannot find all the plots: #{row[0]}" unless plots.count == plot_numbers.size
      member = Member.create!(
        status: :active,
        plots: plots,
        fio: row[1],
        address: row[2],
        phone: row[3],
        email: row[4]
      )
      puts "Created: #{member.inspect}"
    end
  end
end
