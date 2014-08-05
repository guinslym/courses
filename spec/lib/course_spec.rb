require_relative "../spec_helper"
require 'open-uri'
require 'nokogiri'

class Course
  attr_accessor :code, :titre, :description, :prerequis, :credit, :data
  def initialize()
    @data = Nokogiri::HTML(open("http://www.etudesup.uottawa.ca/Default.aspx?tabid=1726&monControl=Programmes&ProgId=985"))
  end
end

RSpec.describe "Course" do
  it "should contains data" do
    course = Course.new
    expect(course.data).to be_truthy
    expect(course.data.size).to eq(20)
  end
end
