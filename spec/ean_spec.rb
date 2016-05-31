require_relative "spec_helper"
require_relative "support/sample_values"

describe "EAN::Ean" do
  include SpecHelpers

  it "should generate for all zeros" do
    EAN.generate_check_digit("0-00000-00000").should == "0"
  end

  it "should generate for single 1s" do
    EAN.generate_check_digit("1-00000-00000").should == "7"
    EAN.generate_check_digit("0-10000-00000").should == "9"
    EAN.generate_check_digit("0-01000-00000").should == "7"
    EAN.generate_check_digit("0-00100-00000").should == "9"
    EAN.generate_check_digit("0-00010-00000").should == "7"
    EAN.generate_check_digit("0-00001-00000").should == "9"
    EAN.generate_check_digit("0-00000-10000").should == "7"
    EAN.generate_check_digit("0-00000-01000").should == "9"
    EAN.generate_check_digit("0-00000-00100").should == "7"
    EAN.generate_check_digit("0-00000-00010").should == "9"
    EAN.generate_check_digit("0-00000-00001").should == "7"
  end

  it "should generate for real numbers" do
    sample_values.each do |value|
      (value.chop + EAN.generate_check_digit(value.chop)).should == value
    end
  end

  it "should validate for GTIN-8" do
    EAN.generate_check_digit("1234555").should == "7"
  end

  it "should generate for GTIN-13" do
    EAN.generate_check_digit("123456789012").should == "8"
  end

  it "should generate for GTIN-14" do
    EAN.generate_check_digit("1234567890123").should == "1"
  end

  it "should ignore non numbers" do
    EAN.ean?("7sdasdasda8sdsa47asdsa9asda4as0adsa0asda1adsa60asdasdas!${%^&*}2").should == true
  end

  it "should validate for all zeros" do
    EAN.generate_check_digit("0-00000-00000-0").should == "0"
  end

  it "should validate for single 1s" do
    EAN.ean?("1-00000-00000-7").should == true
    EAN.ean?("0-10000-00000-9").should == true
    EAN.ean?("0-01000-00000-7").should == true
    EAN.ean?("0-00100-00000-9").should == true
    EAN.ean?("0-00010-00000-7").should == true
    EAN.ean?("0-00001-00000-9").should == true
    EAN.ean?("0-00000-10000-7").should == true
    EAN.ean?("0-00000-01000-9").should == true
    EAN.ean?("0-00000-00100-7").should == true
    EAN.ean?("0-00000-00010-9").should == true
    EAN.ean?("0-00000-00001-7").should == true
  end

  it "should validate for real numbers" do
    sample_values.each do |value|
      EAN.ean?(value).should == true
    end
  end

  it "should validate for GTIN-8" do
    EAN.ean?("12345557").should == true
  end

  it "should validate for GTIN-13" do
    EAN.ean?("1234567890128").should == true
  end

  it "should validate for GTIN-14" do
    EAN.ean?("12345678901231").should == true
  end

  it "should convert all 4 cases to gtin" do
    EAN.to_gtin("12345557").should == "00000012345557"
    EAN.to_gtin("784794001602").should == "00784794001602"
    EAN.to_gtin("1234567890128").should == "01234567890128"
    EAN.to_gtin("12345678901231").should == "12345678901231"
  end

  it "should validate converted gtin-14" do
    EAN.ean?(EAN.to_gtin("12345557")).should == true
    EAN.ean?(EAN.to_gtin("784794001602")).should == true
    EAN.ean?(EAN.to_gtin("1234567890128")).should == true
    EAN.ean?(EAN.to_gtin("12345678901231")).should == true
  end
end
