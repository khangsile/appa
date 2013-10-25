require 'spec_helper'

describe Car do
 	let(:car) { FactoryGirl.create :car }

 	it { should respond_to :model }
 	it { should respond_to :driver_id }
 	it { should respond_to :num_seats }
 	it { should respond_to :year }

 	context "when year is missing" do
 		it "is nil" do
 			car.year = nil
 			expect(car).to be_invalid
 		end
 	end

 	context "when driver_id is missing" do
 		it "is nil" do
 			car.driver_id = nil
 			expect(car).to be_invalid
 		end
 	end

 	context "when num_seats is invalid" do
 		it "is nil" do
 			car.num_seats = nil
 			expect(car).to be_invalid
 		end

 		it "is less than 0" do
 			car.num_seats = -1
 			expect(car).to be_invalid
 		end
 	end

 	context "when model is missing" do
 		it "is nil" do
 			car.model = nil
 			expect(car).to be_invalid
 		end
 	end
 	
end
