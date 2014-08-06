require_relative "../spec_helper"
require_relative "../course"
require 'open-uri'
require 'nokogiri'
LINK = "http://www.etudesup.uottawa.ca/Default.aspx?tabid=1726&monControl=Programmes&ProgId=985"

RSpec.describe "ProgramCourse" do
  it "should have many divs" do
    classes = ProgramCourse.new(LINK)
    classes = classes.all_courses
    expect(classes.size).to  be >= 5
    #expect(course.data.size).to eq(20)
  end
end
