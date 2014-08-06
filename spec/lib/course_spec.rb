require_relative "../spec_helper"
require_relative "../course"
require 'open-uri'
require 'nokogiri'

RSpec.describe "Course" do
  it "should contains data" do
    course = Course.new
    expect(course.data).to be_truthy
    expect(course.data.size).to eq(20)
  end
end
