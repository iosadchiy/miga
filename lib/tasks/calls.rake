require "csv"

desc "Print phone numbers"
task :print_phones => :environment do
  plot_numbers = %w[306 211 226 256 185 344 184 318 131 169 320 3 254 5 331 131 1
    191 364 363 30 142а 128 298 269 116 328]
  plot_numbers.map(&:upcase).map{|number| Member.owner_of(number)}.uniq.map(&:decorate).each do |member|
    csv = CSV.generate do |csv|
      csv << [
        member.plot_list_text,
        member.fio,
        member.phone
      ]
    end
    puts csv
  end
end
