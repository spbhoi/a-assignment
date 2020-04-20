# Assignment -1
#Example -1
def get_addresses
	addresses = []
	User.all.collect{|user| addresses << user.address if 			 user.address.city.present?}
end
#Example -2
class Greeting
	attr_accessor :name
	def initialize(name)
		@name = name
	end
end
greeting = Greeting.new("sachin")
greeting.name

#Example -3
def sum(*params)
	params.sum
end
sum([2, 3]) #=> 5
sum([1,2,3,4]) # => 10

# Assignment -2
#Example -1
class User
	attr_accessor :status
	def initialize(status)
		@status= status
	end

	["active", "inactive", "pending"].each do |s|
		define_method :"#{s}?" do
			self.status == s
		end
	end
end


class Tournament
	attr_accessor :status, :team_1, :team_2
	TEAMS = ["Team A", "Team B", "Team C","Team D"]
	@@score = [
		{"mp" => 0,"w" => 0,"d" =>0,"l" => 0,"p" =>0},
		{"mp" => 0,"w" => 0,"d" =>0,"l" => 0,"p" =>0},
		{"mp" => 0,"w" => 0,"d" =>0,"l" => 0,"p" =>0},
		{"mp" => 0,"w" => 0,"d" =>0,"l" => 0,"p" =>0},
			]
	def initialize(result) #result is a Array like ["Team A","Team B","win"]
		@team_1 = result[0]
		@team_2 = result[1]
		@status =  result[2]
		update_score
	end
	def update_score
		case @status
		when "win"
			update_winning_score(@team_1, @team_2) #team_1 is winning team 
		when "lost"
			update_winning_score(@team_2, @team_1) #team_2 is winning team
		when "draw"
			update_draw_score
		end
	end
	def update_draw_score
		possition = TEAMS.find_index(@team_1)
		set_score(possition,0,1,0,1)
		possition = TEAMS.find_index(@team_2)
		set_score(possition,0,1,0,1)
	end
	def update_winning_score(winner_team, lost_team) 
		possition = TEAMS.find_index(winner_team)
		set_score(possition,1,0,0,3)
		possition = TEAMS.find_index(lost_team)
		set_score(possition,0,0,1,0)
	end
	def set_score(possition,win,draw,lost,point)
		@@score [possition]["mp"] += 1
		@@score [possition]["w"] += win
		@@score [possition]["d"] += draw
		@@score [possition]["l"] += lost
		@@score [possition]["p"] += point
	end
	def show_score
	puts "Team\t| MP |\t| W |\t| D |\t| L |\t| P |"
	@@score.each_with_index do |s, index|
		puts "#{TEAMS[index]}\t| #{s["mp"]} |\t| #{s["w"]} |\t| #{s["d"]} |\t| #{s["l"]} |\t| #{s["p"]} |"
	end
	# puts @@score 
	end
end
 t= Tournament.new(["Team D","Team B","loss"])
t.show_score
