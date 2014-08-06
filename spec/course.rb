require 'open-uri'
require 'nokogiri'
require 'ascii_charts'
require 'terminal-table'

class Lecture
  attr_accessor :code, :title, :description, :prerequis, :credit

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


##############################################
class ProgramCourse
  attr_accessor :divs_found
  def initialize(uottawa_link)
    document = Nokogiri::HTML(open(uottawa_link))
    strating_point = document.xpath("/html/body/form/div[3]/div[7]/section/div/div[2]/div/div/div/div[2]/div/div/div[4]/div[5]")
    @divs_found = strating_point.children
  end

  def all_courses
      find_courses = []
      if @divs_found
        #I need to refactor [3..75] I'm not supposed to put number
        divs_found.each do |courses|
          if courses.children[0] && courses.children[0].content.split.first.match(/\d{4}/)
            c = Lecture.new(courses)
            find_courses << c

          end#if
      end#do
    end#if

    return find_courses

  end#def

end#end class

#HOW TO CALL THIS PROGRAM
classes = ProgramCourse.new("http://www.etudesup.uottawa.ca/Default.aspx?tabid=1726&monControl=Programmes&ProgId=985")
classes = classes.all_courses

total = 0
classes.each { |n| total += 1 if n.prerequis.eql? false }
puts "size = #{classes.size} and total #{total}"




puts AsciiCharts::Cartesian.new([["without-prerequisite", total],["prerequise", classes.size-total] ], bar: true, :title => 'nb Courses with/without prerequisites').draw

table = Terminal::Table.new do |t|
  t << ['One', 1]
  t << :separator
  t.add_row ["Two\nDouble", 2]
  t.add_separator
  t.add_row ['Three', 3]
end
table.align_column(1, :right)
table << ["Four", {:value => 4.0, :alignment => :center}]
puts table
#TODO how to make this programm more like a Service Oriented object