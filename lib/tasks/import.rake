require "csv"

namespace :import do
  desc "Import plots and members from fixtures"
  task :default do
    Rake::Task["import:plots"].invoke("test/fixtures/plots.csv")
    Rake::Task["import:members"].invoke("test/fixtures/members.csv")
    Rake::Task["import:create_registers"].invoke
    Rake::Task["import:membership_2016"].invoke("test/fixtures/membership_2016.csv")
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
        registers = plot.registers.create!([
          {kind: :electricity, name: plot.number},
          {kind: :water, name: plot.number}
        ])
        puts "Created: #{registers.inspect}"
      end
  end

  desc "Import debts for membership dues 2016"
  task :membership_2016, [:csv_file] => [:environment] do |task, args|
    due = Due.find_by!(kind: :membership, purpose: "2016")
    CSV.foreach(args.csv_file, headers: :first_row) do |row|
      plot_numbers = row[0].split(",").map(&:strip)
      debt = row[2].to_f

      member = Member.owner_of(plot_numbers.first)
      if member.plots.pluck(:number).sort != plot_numbers.sort
        raise "Invalid plots specified for member #{member.inspect};
          specified: #{plot_numbers.sort.inspect};
          member has: #{member.plots.pluck(:number).sort.inspect}"
      end
      member.dues << due
      if member.space == 0
        space = (debt / due.price).round
        puts "Updating member's space"
        member.plots.first.update(space: space)
      end
      if debt > due.altogether_for(member)
        raise "Member's debt is larger than the full due. Member: #{member.inspect};
          debt: #{debt};
          full due: #{due.altogether_for(member)}"
      end
      if debt < due.altogether_for(member)
        member.payments.create!(
          transactions: [
            Transaction.new(
              kind: :due,
              payable: due,
              total: due.altogether_for(member) - debt,
              details: {purpose: "Adjustment on import"}
            )
          ]
        )
      end
    end
  end
end
