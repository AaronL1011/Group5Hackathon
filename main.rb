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


def main (userName) # Aaron
    while true
        mainMenu = TTY::Prompt.new
        puts `clear`
        userChoice = mainMenu.select("Well, " + userName + ", What can I help you with in this trying time?!~", ["Exercise!", "Help me! I feel so alone...", "I've been inside for so long, what day is it?", "Give me some updates, I'm scared!", "LET ME OUT!!!"])
        if userChoice == "Exercise!"
            puts `clear`
            puts "Okay!~ Lets get physical!"
            spriteHappy()
            sleep(4)
            puts `clear`
            exersizes()
        elsif userChoice == "Help me! I feel so alone..."
            puts `clear`
            puts "Oh my poor " + userName + ", let me lift your spirits!!"
            spriteSad()
            sleep(4)
            puts `clear`
            companion()
        elsif userChoice == "I've been inside for so long, what day is it?"
            puts `clear`
            puts "Its easy to forget how long its been since you've seen the sun!~"
            spriteConfused()
            sleep(4)
            puts `clear`
            what_day_is_it()
        elsif userChoice == "Give me some updates, I'm scared!"
            puts `clear`
            puts "Oh boy, I'll be honest, its not looking good!~"
            spriteScared()
            sleep(4)
            puts `clear`
            covid_updates()
        elsif userChoice == "LET ME OUT!!!"
            puts `clear`
            puts "Ohh... owkay.. sowwy..."
            puts "(╥﹏╥)"
            sleep(5)
            break
        end
    end
end


def exersizes() # Vicky    
    exersizes_hash = {
        "15_mins" => {"Sit Ups" => "15 reps 3 times",
                    "Crunch" => "15 reps 3 times", 
                    "Push Ups" => "20 reps 3 times"
        },
        "20_mins" => {"Frogger" => "18 reps 4 times",
                      "Bird-dog-crunch"=>"20 reps 4 times",
                      "Point-toe-touch" => "20 each side",
        },
        "30_mins" => {"Stair Climb" => "100 steps",
                    "Frog jumps" => "100 reps",
                    "Skip" =>"10 minutes",
        }
    }
    exerciseChoice = TTY::Prompt.new
    beautiful_monster = exerciseChoice.select("How long do you want to do your exercise?~", ["15 minutes", "20 minutes", "30 minutes"])


    if beautiful_monster == "15 minutes"
        puts "Okay! Write this down!!~"
        exersizes_hash["15_mins"].each do |key, value|
            puts "Do " + key.to_s + " for " + value.to_s
        end
        sleep(20)
    elsif beautiful_monster == "20 minutes"
        puts "Okay! Write this down!!~"
        exersizes_hash["20_mins"].each do |key,value|
            puts "Do " + key.to_s + " for " + value.to_s
        end
        sleep(20)
    elsif beautiful_monster == "30 minutes"
        puts "Okay! Write this down!!~"
        exersizes_hash["30_mins"].each do |key,value|
            puts "Do" + key.to_s + " for " + value.to_s
        end
        sleep(20)
    end
    
end

def get_time() # Team Work
    time = Time.new
    return time.strftime("Today is %A, %d of %B, %Y.")  
end

def what_day_is_it() # Matt
    box1 = TTY::Box.frame(width: 30, height: 5, align: :center, title: 
    {bottom_left: '──────v'}) do get_time
    end
    
    print box1  
    puts spriteDay
    sleep(5)
end

def covid_updates() # Aaron
    regionChooser = TTY::Prompt.new
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

    regionChoice = regionChooser.select("Where are you concerned about???~", %w(Australia NSW QLD VIC SA NT WA ACT TAS))

    puts `clear`
    puts TTY::Box.frame "\nThe current statistics of the Coronavirus are as follows!:\n\n"
        if regionChoice == "ACT"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][0]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][0]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][0]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][0]["recovered"].to_s + " recoveries!"
        elsif regionChoice == "NSW"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][1]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][1]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][1]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][1]["recovered"].to_s + " recoveries!"
        elsif regionChoice == "NT"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][2]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][2]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][2]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][2]["recovered"].to_s + " recoveries!"
        elsif regionChoice == "QLD"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][3]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][3]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][3]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][3]["recovered"].to_s + " recoveries!"
        elsif regionChoice == "SA"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][4]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][4]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][4]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][4]["recovered"].to_s + " recoveries!"
        elsif regionChoice == "TAS"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][5]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][5]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][5]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][5]["recovered"].to_s + " recoveries!"
        elsif regionChoice == "VIC"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][6]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][6]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][6]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][6]["recovered"].to_s + " recoveries!"
        elsif regionChoice == "WA"
            puts "The latest stats of " + bodyHash["data"]["covid19Stats"][7]["province"] + " are:"
            puts bodyHash["data"]["covid19Stats"][7]["confirmed"].to_s + " confirmed cases,"
            puts bodyHash["data"]["covid19Stats"][7]["deaths"].to_s + " deaths,"
            puts "and " + bodyHash["data"]["covid19Stats"][7]["recovered"].to_s + " recoveries!"
        elsif regionChoice == "Australia"
            puts "Australia has " + totalCases.to_s + " total cases!!!!!!"
            puts totalDeaths.to_s + " total deaths,"
            puts "and " + totalRecoveries.to_s + " total recoveries!"
        end
        spriteFreakOut()
        sleep(4)
        puts "If my numbers are incorrect, you can blame Johns Hopkins University (⁄ ⁄•⁄ω⁄•⁄ ⁄)"
        sleep(10)
end

def companion() # Matt
    def box()
        box = TTY::Box.frame(width:40, height:5, align: :center, title: 
        {bottom_left: '──────v'}) do  Quotes_list.sample.quote_str

        end
    end

    puts box 
    puts spriteQuote
    sleep(8)
end

puts `clear`
puts "Ech hem... *clears throat*"
sleep(5)
puts `clear`
puts "Hewwo! It looks like you're in isowation..."
spriteSad()
sleep(4)
puts `clear`
puts "I'm here to get you through the day! Let's be fwends!"
spriteHappy()
sleep(4)
puts `clear`
puts "What is your name, fwend?"
spriteConfused()
userName = gets.chomp
main(userName)