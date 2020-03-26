
class Quotes
    attr_accessor :string, :author

    def initialize(string, author)
        @string = string
        @author = author
    end

    def quote_str
        return "#{string} - #{author}."
    end
end

Quotes_list = [
Quotes.new("Happiness is when what you think, what you say, and what you do are in harmony.", "Mahatma Gandhi"),
Quotes.new("The most important thing is to enjoy your life—to be happy—it's all that matters.", "Audrey Hepburn"),
Quotes.new("Happiness is a warm puppy.", "Charles M. Schulz"),
Quotes.new("No medicine cures what happiness cannot.", "Gabriel García Márquez"),
Quotes.new("Let us be grateful to the people who make us happy; they are the charming gardeners who make our souls blossom.", "Marcel Proust"),
Quotes.new("Sanity and happiness are an impossible combination.", "Mark Twain"),
Quotes.new("Dattebayo", "Naruto Uzumaki"),
Quotes.new("The best thing about the future is that it comes one day at a time", "Abraham Lincoln"),
Quotes.new("Nobody realizes that some people expend tremendous energy merely to be normal.", "Albert Camus"),
Quotes.new("The average dog is a nicer person than the average person.", "Andy Rooney"),
Quotes.new("I don’t believe in astrology; I’m a Sagittarius and we’re skeptical", "Arthur C. Clarke"),
Quotes.new("My opinions may have changed, but not the fact that I’m right.", "Ashleigh Brilliant"),
Quotes.new("Have you noticed that all the people in favor of birth control are already born?", "Benny Hill"),
Quotes.new("He who laughs last didn’t get the joke.", "Charles de Gaulle"),
]

# box = TTY::Box.frame(width:40, height:5, align: :center, title: 
#     {bottom_left: '──────v'})
 
# puts box Quotes_list.sample.quote_str
# puts "( >-_-)>"