require "csv"

namespace :import do
  desc "Import plots and members from fixtures"
  task :default do
    Rake::Task["import:plots"].invoke("test/fixtures/plots.csv")
    Rake::Task["import:members"].invoke("test/fixtures/members.csv")
  end

  desc "Import plots from a CSV file (passed as an argument)"
  # see example: test/fixtures/plots.csv
  task :plots, [:csv_file] => [:environment] do |task, args|
    CSV.foreach(args.csv_file) do |row|
      plot = Plot.create!(
        number: row[0],
        cadastre: row[1],
        space: row[2]
      )
      puts "Created: #{plot.inspect}"
    end
  end

  desc "Import members from a CSV file"
  # see example: test/fixtures/members.csv
  task :members, [:csv_file] => [:environment] do |task, args|
    CSV.foreach(args.csv_file) do |row|
      plot_numbers = row[1].split(/\s*,\s*/)
      plots = plot_numbers.map { |number|
        Plot.find_by(number: number) || Plot.create(number: number, space: 0)
      }
      member = Member.create!(
        status: :active,
        plots: plots,
        fio: row[2],
        address: row[3],
        phone: row[4..6].compact.reject(&:empty?).join(", ")
      )
      puts "Created: #{member.inspect}"
    end
  end

  desc "Create a water and an electricity register for each member"
  task :create_registers => :environment do
    Member.active
      .select{|m| m.registers.empty? }
      .each do |member|
        plot = member.plots.first
        plot.registers.create!([
          {kind: :electricity, name: plot.number},
          {kind: :water, name: plot.number}
        ])
      end
  end
end
