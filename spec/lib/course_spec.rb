require_relative "../spec_helper"
require_relative "../course"
require 'open-uri'
require 'nokogiri'
LINK = "http://www.etudesup.uottawa.ca/Default.aspx?tabid=1726&monControl=Programmes&ProgId=985"

RSpec.describe "ProgramCourse" do
  it "should be an instance of ProgramCourse" do
    classes = ProgramCourse.new(LINK)
    #expect(classes.class).to be_a(ProgramCourse)
  end
  it "should have many divs" do
    classes = ProgramCourse.new(LINK)
    classes = classes.all_courses
    expect(classes.size).to  be >= 5
    #expect(course.data.size).to eq(20)
  end
  it "should raise error without a link" do
    #
  end
  it ".code should contains 4 number" do
    classes = ProgramCourse.new(LINK)
    classes = classes.all_courses
    expect(classes.first.code).to match(/\d{4}/)
  end
end

RSpec.describe "Lecture" do

end
