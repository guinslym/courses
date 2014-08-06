require "./spec/course.rb"


classes = ProgramCourse.new("http://www.etudesup.uottawa.ca/Default.aspx?tabid=1726&monControl=Programmes&ProgId=985")
classes = classes.all_courses

total = 0
n_prerequis_course = []
prerequis_course = []
classes.each do |n| 
  if n.prerequis.eql? false
    total += 1 
    n_prerequis_course << [n.code, n.title]
  else #course with a prerequisite
    prerequis_course << [n.code, n.title]
  end
end
puts "size = #{classes.size} and total #{total}"
#puts n_prerequis_course



puts AsciiCharts::Cartesian.new([["without-prerequisite", total],["prerequise", classes.size-total] ], bar: true, :title => 'nb Courses with/without prerequisites').draw

table = Terminal::Table.new :title => "Course without prerequisites",:headings => ['Courses Code', 'Course Title'] do |t|
  n_prerequis_course.each do |course|
    t.add_row [course.first, course.last]
  end
end
table.align_column(1, :left)

puts table
