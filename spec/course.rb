require 'open-uri'
require 'nokogiri'

class Lecture
  attr_accessor :code, :title, :description, :prerequis, :credit
  BLACKLIST = ["THÈSE","THESIS", "PROJET", "PROJECT"]

  def initialize(course)
      header = course.children[0].content
    @code = header.split.first
    @title = header.split(header.split.first).last.strip!

    if is_course_have_credit?(course.children[1].content)
      @credit = course.children[1].content.split(/[^1-9]/).last + "cr."
    end

    if is_there_a_description?(course.children[3]) && !@code.eql?("ISI6999")
      @description =  course.children[3].content
        prerequis = course.children[4].content
      @prerequis = est_nul?(prerequis)
    elsif (@title.match /TH[EÈ]S[EI]S?/) || (@title.match /PROJE[C]T/)
       @prerequis = true
    end

  end

  def est_nul?(prerequis)
    if prerequis.eql?(" ")
      false
    else
      true
    end
  end

  def is_course_have_credit?(course)
    if course.split(/[^1-9]/).length >= 2
      true
    else
      false
    end
  end

  def is_there_a_description?(course)
    if course
      true
    else
      false
    end
  end
end

def preparation
document = Nokogiri::HTML(open("http://www.etudesup.uottawa.ca/Default.aspx?tabid=1726&monControl=Programmes&ProgId=985"))
main_section = document.xpath("/html/body/form/div[3]/div[7]/section/div/div[2]/div/div/div/div[2]/div/div/div[4]/div[5]")
paragraphs = main_section.children
#puts paragraphs.size

paragraphs = paragraphs[3..75]

courses = []
paragraphs[3..75].each do |course|

  if course.children[0]
    courses << c = Lecture.new(course)

    #puts c.title + " " + c.prerequis.to_s
    #puts c.description if !c.description.nil?
  end
end
return courses
end

courses = preparation

 nbr_courses_with_prerequisites = []
 courses.each do |course| 
   unless (course.prerequis)
    #puts course.prerequis
     nbr_courses_with_prerequisites << course.code
   end
end
 puts "courses without prerequisites #{nbr_courses_with_prerequisites.size}"
 puts "number total of course #{courses.size}"
 nbr_courses_with_prerequisites.each {|n| puts n}