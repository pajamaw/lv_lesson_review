require 'rubygems'
require 'mechanize'

class LessonsScraper

  def run
    get_page
    get_info_blocks
    get_category_and_lesson_titles
  end

  def agent
    agent = Mechanize.new
  end

  def get_page
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

  def get_info_blocks
    info = get_page.search('div[data-topic-slug]')
  end

  def get_category_and_lesson_titles
    get_info_blocks.each do |lesson_block|
      if lesson_block.css('div div h3').text != ""
        @category = Category.new(title: lesson_block.css('div div h3').text)
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

    #agent = Mechanize.new

    #page = agent.get('http://www.learn.co/pajamaw.html')

    #info = page.search('div[data-topic-slug]')



