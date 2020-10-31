require "./spec_helper"

describe Parameters do
  describe ".parse" do
    it "parses args" do
      args = Parameters.parse("!this is -a  command --with some --flags")
      args.should eq(["!this", "is", "-a", "command", "--with", "some", "--flags"])
    end

    it "handles double quotes" do
      args = Parameters.parse(%(!this is "a  command" --))
      args.should eq(["!this", "is", "a  command", "--"])
    end

    it "handles simple quotes" do
      args = Parameters.parse(%(!this is 'a  command'))
      args.should eq(["!this", "is", "a  command"])
    end

    it "handles very weird cases" do
      args = Parameters.parse(%(!this 'is a "'very wei"rd co"m"mand please" don't do t'h'a't p"leas"e))
      args.should eq(["!this", %(is a "very), "weird command please", "dont do that", "please"])
    end

    it "handles error" do
      args = Parameters.parse(%(!this is an "error))
      args.should be_nil
    end
  end
end
