# Application starts on main function, greeted with friendly companion.
# Based on the time, companion will recommend exersizes, sleep times, and what day it is.
# Companion will post updates on news articles related to COVID

#People should get up, walk around/exersize every hour for ~15minutes.
require './sprite.rb'
require 'uri'
require 'net/http'
require 'openssl'
require './quotes.rb'
require 'json'
require 'tty-box'
require 'tty-prompt'


def main () # Aaron
    mainMenu = TTY::Prompt.new
    puts `clear`
    puts "Hello! It looks like you're in isolation..."
    sleep(0.2)
    spriteSad()
    sleep(4)
    puts `clear`
    puts "I'm here to get you through the day! Let's be friends!"
    sleep(0.2)
    spriteHappy()
    sleep(4)
    puts `clear`
    puts "What is your name, friend?"
    spriteConfused()
    userName = gets.chomp
    puts `clear`
    mainMenu.select("Well, " + userName + ", What can I help you with in this trying time?!~", ["Exercise!", "Help me! I feel so alone...", "I've been inside for so long, what day is it?", "Give me some updates, I'm scared!"])
end


def exersizes() # Vicky    
    exersizes_hash = {
        "15_mins" => {"sit-up" => "15 reps_3times",
                    "crunch" => "15 reps_3times", 
                    "push-up" => "20 reps_3times"
        },
        "20_mins" => {"froger" => "18 reps_4 times",
                      "bird-dog-crunch"=>"20 reps_4 times",
                      "point-toe-touch" => "20 each side",
        },
        "30_mins" => {"run-on-stairs" => "100_step",
                    "frog_jump" => "100",
                    "skip" =>"100",
        }
    }
    puts "How long do you want to do your excersice? (15 minutes, 20 minutes, 30 minutes)"
    beautiful_monster = gets.chomp

    if beautiful_monster == "15 minutes"
            # puts "Well start, you are on good track! please follow the instruction: " + exersizes_hash["15_mins"].to_s
            exersizes_hash["15_mins"].each do |key, value|
                puts "Do " + key.to_s + " for " + value.to_s
            end
    elsif beautiful_monster == "20 minutes"
            exersizes_hash["20_mins"].each do |key,value|
                puts "Do " + key.to_s + " for " + value.to_s
            end

    elsif beautiful_monster == "30 minutes"
            exersizes_hash["30_mins"].each do |key,value|
                puts "Do" + key.to_s + " for " + value.to_s
            end
    end
# def excersice()
    
end

def sleep_times() # Vicky

end

def what_day_is_it() # Matt
    time = Time.new
    puts time.strftime("Today is %A, %d of %B, %Y.")  
end

def covid_updates() # Aaron
    url = URI("https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country=Australia")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'covid-19-coronavirus-statistics.p.rapidapi.com'
    request["x-rapidapi-key"] = 'b83f0cb687msh7e68d680c9bce5fp12573djsn13d67125fad3'

    response = http.request(request)
    bodyHash = JSON.parse(response.read_body)
    # puts JSON.pretty_generate(bodyHash)

    totalCases = bodyHash["data"]["covid19Stats"][0]["confirmed"] + bodyHash["data"]["covid19Stats"][1]["confirmed"] + bodyHash["data"]["covid19Stats"][2]["confirmed"] + bodyHash["data"]["covid19Stats"][3]["confirmed"] + bodyHash["data"]["covid19Stats"][4]["confirmed"] + bodyHash["data"]["covid19Stats"][4]["confirmed"] + bodyHash["data"]["covid19Stats"][5]["confirmed"] + bodyHash["data"]["covid19Stats"][6]["confirmed"] + bodyHash["data"]["covid19Stats"][7]["confirmed"]
    totalDeaths = bodyHash["data"]["covid19Stats"][0]["deaths"] + bodyHash["data"]["covid19Stats"][1]["deaths"] + bodyHash["data"]["covid19Stats"][2]["deaths"] + bodyHash["data"]["covid19Stats"][3]["deaths"] + bodyHash["data"]["covid19Stats"][4]["deaths"] + bodyHash["data"]["covid19Stats"][4]["deaths"] + bodyHash["data"]["covid19Stats"][5]["deaths"] + bodyHash["data"]["covid19Stats"][6]["deaths"] + bodyHash["data"]["covid19Stats"][7]["deaths"]
    totalRecoveries = bodyHash["data"]["covid19Stats"][0]["recovered"] + bodyHash["data"]["covid19Stats"][1]["recovered"] + bodyHash["data"]["covid19Stats"][2]["recovered"] + bodyHash["data"]["covid19Stats"][3]["recovered"] + bodyHash["data"]["covid19Stats"][4]["recovered"] + bodyHash["data"]["covid19Stats"][4]["recovered"] + bodyHash["data"]["covid19Stats"][5]["recovered"] + bodyHash["data"]["covid19Stats"][6]["recovered"] + bodyHash["data"]["covid19Stats"][7]["recovered"]


    puts "Where are you concerned about??? (Australia, NSW, QLD, VIC, SA, NT, WA, ACT or TAS)"
    regionChoice = gets.chomp
    puts `clear`
    puts "The current statistics of the Coronavirus are as follows!:"
    validChoice = false
    while !validChoice
        if regionChoice == "ACT"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][0]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][0]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][0]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][0]["recovered"].to_s + " recoveries!"
            validChoice = true
        elsif regionChoice == "NSW"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][1]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][1]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][1]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][1]["recovered"].to_s + " recoveries!"
            validChoice = true
        elsif regionChoice == "NT"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][2]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][2]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][2]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][2]["recovered"].to_s + " recoveries!"
            validChoice = true
        elsif regionChoice == "QLD"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][3]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][3]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][3]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][3]["recovered"].to_s + " recoveries!"
            validChoice = true
        elsif regionChoice == "SA"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][4]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][4]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][4]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][4]["recovered"].to_s + " recoveries!"
            validChoice = true
        elsif regionChoice == "TAS"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][5]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][5]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][5]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][5]["recovered"].to_s + " recoveries!"
            validChoice = true
        elsif regionChoice == "VIC"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][6]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][6]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][6]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][6]["recovered"].to_s + " recoveries!"
            validChoice = true
        elsif regionChoice == "WA"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][7]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][7]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][7]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][7]["recovered"].to_s + " recoveries!"
            validChoice = true
        elsif regionChoice == "Australia"
            puts "Australia has " + totalCases.to_s + " total cases!!!!!!"
            puts totalDeaths.to_s + " total deaths,"
            puts "and " + totalRecoveries.to_s + " total recoveries!"
            validChoice = true
        else
            puts "Please enter a valid choice!~"
        end
    end
end

def companion() # Matt
    def box()
        box = TTY::Box.frame(width:40, height:5, align: :center, title: 
        {bottom_left: '──────v'}) do  Quotes_list.sample.quote_str

        end
    end

puts box 
puts spriteQuote
end

main()
