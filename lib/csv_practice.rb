require 'csv'
require 'awesome_print'

def get_all_olympic_athletes(filename)
  table_all = CSV.open(filename, headers: true).map { |row|
    row.to_h
  }
  needed_data = ["ID","Name","Height","Team","Year","City","Sport","Event","Medal"]

  olympic_data = table_all.map do |player|
    player.select { |key, value|
      needed_data.include? key }
  end

  return olympic_data #an array of hashes
end

def total_medals_per_team(olympic_data)
  medals_data = olympic_data.map do |player|
    player.select { |key, value|
      player["Medal"] != "NA"
    }
  end

  medals_data.delete_if { |player| player.empty?}

  teams = medals_data.map { |team| team["Team"]}
  teams.uniq!

  medals = medals_data.select {|team| team["Medal"]}.count

  medals_per_team = Hash[teams.map {|team| [team, 0]}]

  medals_data.each do |row|
    row.each do |key, value|
     if teams.include? value
      medals_per_team[value] += 1
     end
    end
    end

  return medals_per_team
end

# def get_all_gold_medalists(olympic_data)
# end