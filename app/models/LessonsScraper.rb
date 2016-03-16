require 'rubygems'
require 'mechanize'

class LessonsScraper

  def agent
    Mechanize.new
  end

  def page
    page = agent.get('http://www.learn.co/pajamaw.html')
  end

  def lesson_titles
    page.search(".lesson td span").collect{|title| title.text}
  end

  def category_titles
    page.search('div[data-topic-slug] div div h3').collect{ |category| category.text}
  end

  def lesson_titles_with_other_shit_a_new_way
    page.search('div[data-topic-slug] tr.lesson').collect{|lesson| lesson.text} 
  end

  def each_block
    
    agent = Mechanize.new

    page = agent.get('http://www.learn.co/pajamaw.html')

    info = page.search('div[data-topic-slug]')


info.each do |lesson_block|
    if lesson_block.css('div div h3').text != ""
      @category = Category.new(title: lesson_block.css('div div h3').text)
      puts @category
      lesson_block.css('tr.lesson').each do |lesson|
        @lesson = Lesson.new(title: lesson.text)
          @lesson.category_id = @category.id
          @category.lessons << @lesson
          @category.save
          @lesson.save
        end
      end
    end
  end
end

info.each do |lesson_block|

    lesson_block.css('tr.lesson').each do |lesson|
      puts lesson.text
    end
  end